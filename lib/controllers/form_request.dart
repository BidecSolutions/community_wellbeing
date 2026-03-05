// import 'dart:convert';
// import 'package:community_app/app_settings/settings.dart';
// import 'package:community_app/models/app_categories_model.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class FoamController extends GetxController {
//   var isLoading = false.obs;
//   var foamData = {}.obs;
//   var requests = <Map<String, dynamic>>[].obs;

//   Future<void> fetchFoam(int id) async {
//     try {
//       isLoading.value = true;
//       final url = Uri.parse('${AppSettings.baseUrl}registry/fetchFoam');

//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"id": id}),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         foamData.value = {
//           "id": data["id"],
//           "name": data["name"],
//           "is_description_box": data["is_description_box"],
//           "is_size": data["is_size"],
//           "is_item_name": data["is_item_name"],
//           "is_quantity": data["is_quantity"],
//           "status": data["status"],
//         };

//         if (data["request"] != null) {
//           requests.value = List<Map<String, dynamic>>.from(
//             data["request"].map(
//               (req) => {
//                 "id": req["id"],
//                 "user_id": req["user_id"],
//                 "sa2_id": req["sa2_id"],
//                 "address": req["address"],
//               },
//             ),
//           );
//         }
//       } else {
//         Get.snackbar("Error", "Failed to load foam data");
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
