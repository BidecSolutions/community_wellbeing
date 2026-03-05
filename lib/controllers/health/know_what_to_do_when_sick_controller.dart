import 'dart:ui';
import 'package:get/get.dart';


class KnowWhatToDoWhenSickController extends GetxController {
  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[
    {
      'image': 'assets/images/health/running_nose.png',
      'text': 'Running Nose',
      'bgColor': Color(0xFFFEDBDF),
      'bullets': [
        'Drink warm fluids',
        'Use a saline spray',
        'Rest indoors',
      ],
    },
    {
      'image': 'assets/images/health/mild_cough.png',
      'text': 'Mild Cough',
      'bgColor': Color(0xFFD5EBFF),
      'bullets': [
        'Drink honey with warm water',
        'Avoid cold drinks',
        'Use cough drops if needed',
      ],
    },
    {
      'image': 'assets/images/health/upset_stomach.png',
      'text': 'Upset Stomach',
      'bgColor': Color(0xFFFFF0CA),
      'bullets': [
        'Eat light meals',
        'Stay hydrated',
        'Avoid spicy food',
      ],
    },
    {
      'image': 'assets/images/health/lower_fever.png',
      'text': 'Low Fever',
      'bgColor': Color(0xFFCDFFDA),
      'bullets': [
        'Take paracetamol',
        'Drink fluids',
        'Avoid physical exertion',
      ],
    },
  ].obs;

  final RxInt selectedIndex = 0.obs;
}

