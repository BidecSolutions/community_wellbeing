import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:community_app/app_settings/settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import '../database/database_function.dart';



class LoginController extends GetxController {
  final emailControllerText   = TextEditingController();
  final passwordControllerText = TextEditingController();
  final errorMessage           = RxnString();
  final isLoading              = false.obs;
  final rememberMe = false.obs;
  final isPasswordVisible      = false.obs;
  final box                    = GetStorage();


  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id ;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? const Uuid().v4();
    } else {
      return const Uuid().v4();
    }
  }




  Future<void> login() async {
    final email    = emailControllerText.text.trim();
    final password = passwordControllerText.text;

    if (email.isEmpty) {
      errorMessage.value = 'Please enter your email address';
      return;
    }
    if (password.isEmpty) {
      errorMessage.value = 'Please enter the password';
      return;
    }

    try {
      isLoading.value  = true;
      errorMessage.value = null;
      final url = Uri.parse(
        '${AppSettings.baseUrl}auth/login',
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final apiResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await box.write('token',   apiResponse['data']['access_token']);
        await box.write('user_id', apiResponse['data']['user']['id']);
        await box.write('name',    apiResponse['data']['user']['name']);
        await box.write('email',   apiResponse['data']['user']['email']);
        await box.write('address', apiResponse['data']['user']['address']);
        await box.write('dob',     apiResponse['data']['user']['dob']);
        await box.write('hin',     apiResponse['data']['user']['hin']);
        await box.write('phone',   apiResponse['data']['user']['phone']);
        await box.write('image',   apiResponse['data']['user']['image']);
        await box.write('cv_link', apiResponse['data']['user']['cv']);
        await box.write('currentDate', DateTime.now());

        if(rememberMe.value == true){
          final deviceID = await getDeviceId();
          insertToken(deviceID,apiResponse['data']['access_token'],apiResponse['data']['user']['id'].toString());
          insertLoginStatus(status: 1.toString());
          await http.post(
            Uri.parse('${AppSettings.baseUrl}auth/insert-token'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'userId': apiResponse['data']['user']['id'],
              'token': apiResponse['data']['access_token'],
              'deviceId': deviceID,
            }),
          );
        }
        Get.offAllNamed('/home');
      }
      else {
        errorMessage.value = 'Email or Password is Wrong';
        return;
      }
    } catch (e) {
      errorMessage.value = 'Network error – please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

}
