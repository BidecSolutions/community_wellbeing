import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:community_app/controllers/e_store_controller/e_store_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'app_settings/settings.dart';
import 'database/database_function.dart';
import 'routes/app_pages.dart';
import 'database/connection.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('ic_community_app');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel description',
    importance: Importance.max,
    priority: Priority.high,
    icon: 'ic_community_app',
  );

  log('🔔 BG Title: ${message.notification?.title}');
  log('🔔 BG Body: ${message.notification?.body}');
  log('🔔 BG Data: ${message.data}');

  LocalNotificationService.showNotification(message);
}

final box = GetStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!Platform.isIOS) {
    await Firebase.initializeApp();
    await FirebaseApi().initNotifications();
    await LocalNotificationService.initialize();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await GetStorage.init();
  final db = UserTokenDatabase();
  await db.database;

  final loginStatus = await checkStatus();
  final initialRoute = loginStatus == true ? Routes.home : Routes.onboard;
  SystemChrome.setPreferredOrientations([]);
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Community App",
      theme: ThemeData(fontFamily: AppFonts.primaryFontFamily),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    );
  }
}

Future<bool> checkStatus() async {
  final status = await getLoginStatus();
  if (status == '1') {
    final records = await getTokenByUserId();
    if (records == null) return false;

    final token = records['token'];
    final url = Uri.parse('${AppSettings.baseUrl}auth/check-token');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final json = jsonDecode(response.body);
      if (json['status'] == true && json['data'] != null) {
        final keysToClear = [
          'token',
          'user_id',
          'name',
          'email',
          'address',
          'dob',
          'phone',
          'image',
        ];
        for (var key in keysToClear) {
          await box.remove(key);
        }
        await box.write('token', token);
        await box.write('user_id', json['data']['id']);
        await box.write('name', json['data']['name']);
        await box.write('email', json['data']['email']);
        await box.write('address', json['data']['address']);
        await box.write('phone', json['data']['phone']);
        await box.write('image', json['data']['image']);
        await box.write('currentDate', DateTime.now().toString());

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  } else {
    return false;
  }
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    if (fCMToken != null) {
      log('FCM Token: $fCMToken');
    } else {
      log('Failed to get FCM Token');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationService.showNotification(message);
      }
    });
  }
}

class LocalNotificationService {
  static final _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_community_app');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'ic_community_app',
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }
}