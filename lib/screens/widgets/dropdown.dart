// category_dropdown.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class Dropdown extends StatelessWidget {
final controller = Get.find();
@override
Widget build(BuildContext context) {
  return Expanded(
    child: InputDecorator(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Category',
        isDense: true,
      ),
      child: DropdownButtonHideUnderline(
        child: Obx(
          () => DropdownButton<int>(
            value: controller.selectedCategoryId.value,
            hint: const Text('Select Category'),
            isExpanded: true,
            items:
                controller.categories.map((categoryMap) {
                  return DropdownMenuItem<int>(
                    value: categoryMap['id'] as int,
                    child: Text(categoryMap['name'] as String),
                  );
                }).toList(),
            onChanged: (int? newId) {
              controller.selectCategory(newId);
            },
          ),
        ),
      ),
    ),
  );
}
