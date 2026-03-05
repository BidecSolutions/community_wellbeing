import 'package:get/get.dart';

class DoYouKnowYourCultureController extends GetxController {
  // Selected child and age group index
  final RxnString selectedLeftValue = RxnString(); // Child's name
  final RxInt selectedRightIndex = 0.obs; // Age group index

  // Checklist state
  final RxMap<String, List<String>> currentChecklistGroups =
      <String, List<String>>{}.obs;
  final RxList<bool> isCheckedList = <bool>[].obs;

  // Full milestone data grouped by category per age group
  final List<Map<String, List<String>>> allMilestoneData = [
    {
      "Movement & Physical Skills": [
        "A. Lifts head when on tummy",
        "B. Pushes up on arms",
        "C. Rolls over (front to back, back to front)",
        "D. Sits with support",
      ],
      "Language & Communication": [
        "A. Coos and gurgles",
        "B. Turns head towards sounds",
        "C. Responds to own name",
        "D. Babbles",
      ],
      "Cognitive Skills": [
        "A. Watches faces intently",
        "B. Reaches for toys",
        "C. Puts objects in mouth",
        "D. Looks for dropped toys",
      ],
      "Social & Emotional": [
        "A. Smiles spontaneously",
        "B. Enjoys playing with others",
        "C. Cries to express needs",
        "D. Responds to affection",
      ],
    },
    {
      "Movement & Physical Skills": [
        "A. Sits without support",
        "B. Crawls or scoots",
        "C. Pulls to stand",
        "D. Cruises along furniture",
        "E. May take first steps",
      ],
      "Language & Communication": [
        "A. Says 'mama' or 'dada'",
        "B. Understands 'no'",
        "C. Waves goodbye",
        "D. Points to desired objects",
      ],
      "Cognitive Skills": [
        "A. Finds hidden objects",
        "B. Puts objects into a container",
        "C. Imitates gestures",
        "D. Plays peek-a-boo",
      ],
      "Social & Emotional": [
        "A. Shows stranger anxiety",
        "B. Shows preference for certain people",
        "C. Plays pat-a-cake",
        "D. Offers toys to others",
      ],
    },
    {
      "Movement & Physical Skills": [
        "A. Walks independently",
        "B. Begins to run",
        "C. Starts climbing furniture",
        "D. Stacks blocks",
        "E. Kicks a ball",
      ],
      "Language & Communication": [
        "A. Says 10–20 words",
        "B. Points to familiar objects",
        "C. Follows simple directions",
        "D. Combines two words (e.g., 'more milk')",
        "E. Names common objects",
      ],
      "Cognitive Skills": [
        "A. Imitates actions",
        "B. Explores through trial and error",
        "C. Understands object permanence",
        "D. Sorts shapes and colors",
        "E. Begins pretend play",
      ],
      "Social & Emotional": [
        "A. Shows affection",
        "B. Plays simple pretend",
        "C. May show separation anxiety",
        "D. Copies others (especially adults)",
        "E. Begins to show defiance",
      ],
    },
  ];

  // Computed progress
  double get progress {
    if (isCheckedList.isEmpty) return 0.0;
    return isCheckedList.where((checked) => checked).length /
        isCheckedList.length;
  }

  @override
  void onInit() {
    super.onInit();

    // Initialize default selections
    // selectedLeftValue.value = leftDropdownItems.first;
    selectedRightIndex.value = 0;

    // Setup listeners
    ever(selectedRightIndex, (_) {
      _updateChecklistAndResetProgress();
    });

    ever(selectedLeftValue, (_) {
      _clearChecklistAndProgress();
      // Optional: force age group re-selection or keep it unchanged
    });

    _updateChecklistAndResetProgress(); // Initial load
  }

  // Update checklist and reset progress when age group changes
  void _updateChecklistAndResetProgress() {
    final index = selectedRightIndex.value;

    if (index >= 0 && index < allMilestoneData.length) {
      currentChecklistGroups.value = allMilestoneData[index];
    } else {
      currentChecklistGroups.value = {};
    }

    _resetProgressForCurrentChecklist();
  }

  // Resets the checklist check states
  void _resetProgressForCurrentChecklist() {
    isCheckedList.clear();
    final totalItems = currentChecklistGroups.values.fold(
      0,
      (sum, list) => sum + list.length,
    );
    isCheckedList.addAll(List.filled(totalItems, false));
  }

  // Clear checklist and progress (used when changing child)
  void _clearChecklistAndProgress() {
    currentChecklistGroups.clear();
    isCheckedList.clear();
  }

  // Optional helper if you want all items in one flat list
  List<String> getAllChecklistItems() {
    return currentChecklistGroups.values.expand((list) => list).toList();
  }
}
