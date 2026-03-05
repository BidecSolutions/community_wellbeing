import 'dart:convert';
import 'dart:developer';

import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/profile/test.dart';
import 'package:community_app/models/healthy_living_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HealthyLivingController extends GetxController {
  var selectedTab = 0.obs;
  var selectedDropdown = "".obs;
  var dropdownItems = <String>[].obs;
  var isLoading = false.obs;
  var suggestionList = <SuggestionList>[].obs;
  var categorySuggestionList = <CategorySuggestionList>[].obs;
  var suggestionCategoryDetails = <SuggestionCategoryDetails>[].obs;

  var contentData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    initScreen();
  }

  Future<void> initScreen() async {
    selectedTab.value = 0;

    if (suggestionList.isEmpty) {
      await fetchSuggestion(id: 0);
    }

    if (suggestionList.isNotEmpty) {
      final firstSuggestionId = suggestionList[0].id;
      await fetchSuggestionCategories(id: firstSuggestionId);
      if (categorySuggestionList.isNotEmpty) {
        selectedDropdown.value = categorySuggestionList[0].categoryName ;
        final firstCategoryId = categorySuggestionList[0].id;

        await fetchSuggestionCategoryDetails(id: firstCategoryId);
      }
    }
  }

  Future<void> fetchSuggestion({required int id}) async {
    isLoading(true);
    final url = Uri.parse('${AppSettings.baseUrl}health/suggestions');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );
    final jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      log('Response body: $jsonBody');
      final List data = jsonBody['data'];
      log('Fetched suggestion count: $data');

      suggestionList.value =
          data.map((e) => SuggestionList.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load suggestion');
    }
    // try { } catch (e) {
    //   log('Error in suggestionList: $e');
    // } finally {
    //   isLoading(false);
    // }
  }

  Future<void> fetchSuggestionCategories({required int id}) async {
    isLoading(true);
    final url = Uri.parse('${AppSettings.baseUrl}health/suggestion-categories');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: json.encode({"suggestion_id": id}),
    );

    if (response.statusCode == 201) {
      final jsonBody = json.decode(response.body);
      final List data = jsonBody['data'];
      categorySuggestionList.value =
          data.map((e) => CategorySuggestionList.fromJson(e)).toList();
      log('Fetched category_name count: ${categorySuggestionList.length}');

      for (var category in categorySuggestionList) {
        log('category_name: ${category.categoryName}');
      }
      dropdownItems.value =
          categorySuggestionList
              .map((category) => category.categoryName)
              .toList();
      if (dropdownItems.isNotEmpty) {
        selectedDropdown.value = dropdownItems.first;
      }
    } else {
      log('Failed to load solutions: ${response.statusCode}');
      throw Exception('Failed to load categorySuggestionList');
    }
    // try { } catch (e) {
    //   print("Error in fetchSolutions: $e");
    //   // print("Fetching solutions for suggestion_id: $id");
    // } finally {
    //   isLoading(false);
    // }
  }

  Future<void> fetchSuggestionCategoryDetails({required int id}) async {
    isLoading(true);
    final url = Uri.parse('${AppSettings.baseUrl}health/suggestion-details');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: json.encode({"categoryId": id}),
    );

    if (response.statusCode == 201) {
      final jsonBody = json.decode(response.body);
      final List data = jsonBody['data'];
      contentData.value =
          data.map((e) {
            final detail = SuggestionCategoryDetails.fromJson(e);
            return {
              "title": detail.suggestionHeading,
              "color": _getBoxColor(detail.boxColor),
              "iconColor": _getBoxColor(detail.boxColor),
              "items":
                  detail.details
                      .map((data) => {"name": data, "desc": data})
                      .toList(),
            };
          }).toList();

      suggestionCategoryDetails.value =
          data.map((e) => SuggestionCategoryDetails.fromJson(e)).toList();
      log(
        'Fetched suggestionCategoryDetails count: ${suggestionCategoryDetails.length}',
      );
    } else {
      log('Failed to load suggestionCategoryDetails: ${response.statusCode}');
      throw Exception('Failed to load suggestionCategoryDetails');
    }
  }

  Color _getBoxColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case "orange":
        return const Color(0xFFFFE0B2);
      case "green":
        return const Color(0xFFC8E6C9);
      case "blue":
        return const Color(0xFFBBDEFB);
      case "purple":
        return const Color(0xFFE1BEE7);
      case "red":
        return const Color(0xFFFFCDD2);
      case "yellow":
        return const Color(0xFFFFF9C4);
      case "white":
        return const Color.fromARGB(255, 197, 245, 174);
      default:
        return Colors.grey[200]!;
    }
  }
}
