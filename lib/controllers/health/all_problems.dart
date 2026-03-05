import 'dart:convert';
import 'dart:developer';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/models/all_problems_model.dart';
import 'package:community_app/models/problem_sol_model.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProblemController extends GetxController {
  var isLoading = false.obs;
  var problems = <ProblemModel>[].obs;
  var solutionsList = <ProblemSolutionModel>[].obs;
  var selectedIndex = (-1).obs;
  Future<void> fetchProblems() async {
    try {
      isLoading(true);
      final url = Uri.parse('${AppSettings.baseUrl}health/get-all-problems');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        final List data = jsonBody['data'];
        problems.value = data.map((e) => ProblemModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load problems');
      }
    } catch (e) {
      log('Error in fetchProblems: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> solutions({required int id}) async {
    isLoading(true);
    final url = Uri.parse('${AppSettings.baseUrl}health/get-solution');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
      body: json.encode({"p_id": id}),
    );

    if (response.statusCode == 201) {
      final jsonBody = json.decode(response.body);
      final List data = jsonBody['data'];
      solutionsList.value =
          data.map((e) => ProblemSolutionModel.fromJson(e)).toList();
      log('Fetched solutions count: ${solutionsList.length}');
      for (var sol in solutionsList) {
        log('Solution name: ${sol.name}');
      }
    } else {
      log('Failed to load solutions: ${response.statusCode}');
      throw Exception('Failed to load solutions');
    }
    // try { } catch (e) {
    //   print("Error in fetchSolutions: $e");
    //   // print("Fetching solutions for p_id: $pId");
    // } finally {
    //   isLoading(false);
    // }
  }

  @override
  void onInit() {
    fetchProblems();
    super.onInit();
  }
}
