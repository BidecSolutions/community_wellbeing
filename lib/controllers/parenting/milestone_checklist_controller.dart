import 'package:get/get.dart';

class MilestoneChecklistController extends GetxController {
  var selectedLeftValue = RxnString(); // Child's name
  var selectedRightValue = RxnString(); // Age group

  List<String> leftDropdownItems = ['Micheal', 'Anna', 'Tommy'];
  List<String> rightDropdownItems = ['0-6 months', '7-12 months', '1-2 years'];

  // All your milestone data, categorized by age group
  final Map<String, Map<String, List<String>>> allMilestoneData = {
    '0-6 months': {
      "1.Movement & Physical Skills": [
        "Lifts head when on tummy",
        "Pushes up on arms",
        "Rolls over (front to back, back to front)",
        "Sits with support",
      ],
      "2.Language & Communication": [
        "Coos and gurgles",
        "Turns head towards sounds",
        "Responds to own name",
        "Babbles",
      ],
      "3.Cognitive Skills": [
        "Watches faces intently",
        "Reaches for toys",
        "Puts objects in mouth",
        "Looks for dropped toys",
      ],
      "4.Social & Emotional": [
        "Smiles spontaneously",
        "Enjoys playing with others",
        "Cries to express needs",
        "Responds to affection",
      ],
    },
    '7-12 months': {
      "1.Movement & Physical Skills": [
        "Sits without support",
        "Crawls or scoots",
        "Pulls to stand",
        "Cruises along furniture",
        "May take first steps",
      ],
      "2.Language & Communication": [
        "Says 'mama' or 'dada'",
        "Understands 'no'",
        "Waves goodbye",
        "Points to desired objects",
      ],
      "3.Cognitive Skills": [
        "Finds hidden objects",
        "Puts objects into a container",
        "Imitates gestures",
        "Plays peek-a-boo",
      ],
      "4.Social & Emotional": [
        "Shows stranger anxiety",
        "Shows preference for certain people",
        "Plays pat-a-cake",
        "Offers toys to others",
      ],
    },
    '1-2 years': {
      "1.Movement & Physical Skills": [
        "Walks independently",
        "Begins to run",
        "Starts climbing furniture",
        "Stacks blocks",
        "Kicks a ball",
      ],
      "2.Language & Communication": [
        "Says 10–20 words",
        "Points to familiar objects",
        "Follows simple directions",
        "Combines two words (e.g., 'more milk')",
        "Names common objects",
      ],
      "3.Cognitive Skills": [
        "Imitates actions",
        "Explores through trial and error",
        "Understands object permanence",
        "Sorts shapes and colors",
        "Begins pretend play",
      ],
      "4.Social & Emotional": [
        "Shows affection",
        "Plays simple pretend",
        "May show separation anxiety",
        "Copies others (especially adults)",
        "Begins to show defiance",
      ],
    },
  };

  var currentChecklistGroups = <String, List<String>>{}.obs;
  final RxList<bool> isCheckedList =
      <bool>[].obs; // Made final to maintain reference

  double get progress {
    if (isCheckedList.isEmpty) return 0.0;
    return isCheckedList.where((checked) => checked).length /
        isCheckedList.length;
  }

  @override
  void onInit() {
    super.onInit();

    // Initialize with a default child and age group
    selectedLeftValue.value = leftDropdownItems.first;
    selectedRightValue.value = rightDropdownItems.first;
    _updateChecklistAndResetProgress(); // Initial load

    // Listen for changes in selectedRightValue (age group)
    ever(selectedRightValue, (_) {
      _updateChecklistAndResetProgress();
    });

    // Listen for changes in selectedLeftValue (child's name)
    ever(selectedLeftValue, (_) {
      // When child changes, clear the checklist and progress
      // and also reset the age group dropdown to null or a default,
      // forcing a re-selection for the new child.
      _clearChecklistAndProgress();
      selectedRightValue.value = null; // Important: Clear age group selection
    });
  }

  void _updateChecklistAndResetProgress() {
    final selectedAgeGroup = selectedRightValue.value;
    if (selectedAgeGroup != null &&
        allMilestoneData.containsKey(selectedAgeGroup)) {
      currentChecklistGroups.value = allMilestoneData[selectedAgeGroup]!;
    } else {
      currentChecklistGroups.value = {};
    }

    // Reset progress when age group changes
    _resetProgressForCurrentChecklist();
  }

  void _resetProgressForCurrentChecklist() {
    isCheckedList.clear(); // Clear existing items
    final totalItems = currentChecklistGroups.values.fold<int>(
      0,
      (sum, list) => sum + list.length,
    );
    isCheckedList.addAll(
      List.generate(totalItems, (_) => false),
    ); // Add new false items
  }

  void _clearChecklistAndProgress() {
    currentChecklistGroups.value = {}; // Clear displayed checklist groups
    isCheckedList.clear(); // Clear all progress
  }

  // Helper to get all checklist items as a flat list (useful for displaying if needed)
  List<String> getAllChecklistItems() {
    return currentChecklistGroups.values.expand((list) => list).toList();
  }
}
