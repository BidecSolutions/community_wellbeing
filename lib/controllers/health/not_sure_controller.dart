import 'package:get/get.dart';
class NotSureController extends GetxController {
  var selectedLeftValue = RxnString();
  var selectedRightValue = RxnString();


  final checklistGroups = <String, List<String>>{
    "": [
      "Are you having chest pain or trouble breathing?",
      "Is someone bleeding badly or unconscious?",
      "Has a baby under 3 months had a fever?",
      "Do you feel confused, faint, or extremely unwell?",
      "Have symptoms come on suddenly and severely?"
    ],
  };

  late RxList<bool> isCheckedList;

  double get progress =>
      isCheckedList.where((checked) => checked).length / isCheckedList.length;

  @override
  void onInit() {
    super.onInit();
    final totalItems = checklistGroups.values.fold<int>(0, (sum, list) => sum + list.length);
    isCheckedList = List.generate(totalItems, (_) => false).obs;
    // selectedLeftValue.value = leftDropdownItems.first;
    // selectedRightValue.value = rightDropdownItems.first;
  }
}
