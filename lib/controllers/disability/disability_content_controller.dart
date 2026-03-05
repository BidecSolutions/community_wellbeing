
import 'package:get/get.dart';

class DisabilityContentController extends GetxController {
  var articleDetails = {}.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      articleDetails.value = Get.arguments;

    }
  }
}


