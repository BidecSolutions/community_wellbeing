import 'package:get/get.dart';

class HomeController extends GetxController {
  final counter = 1; // Use RxInt for reactive state
  final List<Map<String, dynamic>> yourActivity =
      [
        {
          'label': 'Continue Budgeting Setup',
          'image': "assets/images/recent_activity_2.png",
        },

        {
          'label': 'Track Your Grant Application',
          'image': "assets/images/recent_activity_1.png",
        },
      ].obs;
}
