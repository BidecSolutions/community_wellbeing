import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../../app_settings/settings.dart';
import '../../main.dart';

class StepCounterController extends GetxController {
  late RxInt stepCount;

  late StreamSubscription<StepCount> _stepSub;
  StreamSubscription<AccelerometerEvent>? _accelSub;

  RxInt previousSensorStep = 0.obs;
  var isLoading = false.obs;

  final double shakeThreshold = 14.0;
  final int debounceTimeMs = 500;
  DateTime lastStepTime = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    int storedValue =
        int.tryParse(box.read('stepCounter')?.toString() ?? '0') ?? 0;
    stepCount = storedValue.obs;
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String storedDate = box.read('currentDate')?.toString() ?? '';
    if (storedDate != today) {
      storeStepCounter();
      stepCount.value = 0;
      box.write('stepCounter', 0);
      box.write('currentDate', today);
    }
    initStepCounter();
    listenForShake();
  }

  void increment() {
    stepCount.value += 1;
    box.write('stepCounter', stepCount.value);
  }

  void initStepCounter() {
    _stepSub = Pedometer.stepCountStream.listen((event) {
      if (previousSensorStep.value == 0) {
        previousSensorStep.value = event.steps;
      }

      int delta = event.steps - previousSensorStep.value;
      if (delta > 0) {
        previousSensorStep.value = event.steps;
        increment(); // store every step persistently
      }
    });
  }

  void listenForShake() {
    _accelSub = accelerometerEventStream().listen((AccelerometerEvent event) {
      double acceleration = sqrt(
        event.x * event.x + event.y * event.y + event.z * event.z,
      );

      if (acceleration > shakeThreshold &&
          DateTime.now().difference(lastStepTime).inMilliseconds >
              debounceTimeMs) {
        lastStepTime = DateTime.now();
        increment();
      }
    });
  }

  Future<void> storeStepCounter() async {
    try {
      isLoading.value = true;
      final url = Uri.parse('${AppSettings.baseUrl}health/save-daily-steps');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: jsonEncode({"steps": stepCount.value}),
      );

      final responseBody = json.decode(response.body);
      if (responseBody['status'] == true) {}
    } catch (e) {
      e;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _stepSub.cancel();
    _accelSub?.cancel();
    super.onClose();
  }
}
