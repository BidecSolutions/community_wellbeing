import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../app_settings/settings.dart';
import 'package:get_storage/get_storage.dart';
class FinanceController extends GetxController {

   final counter = 1;
   int selectedEmergencyId = 0;
   final addressControllerText   = TextEditingController();
   final emergencyControllerText = TextEditingController();
   final situationControllerText = TextEditingController();
   final box = GetStorage();
   final message = RxnString();
   final RxList<Map<String, dynamic>> locations = <Map<String, dynamic>>[
    {
      "title": "Te Tāpui Atawhai",
      "address": "140 Hobson Street, Auckland CBD",
      "services":
      "Provides Food Parcels, Housing Support, Health Services, And Addiction Withdrawal Services. Offers A Community Dining Room Serving Free Meals Daily",
      "contact": "0800 223 663",
      "hours": "Mon, Tue, Thu, Fri: 8:30am – 4:00pm"
    },
    {
      "title": "City Mission",
      "address": "23 City Road, Auckland",
      "services":
      "Emergency housing, food parcels, health care services.",
      "contact": "0800 111 123",
      "hours": "Everyday: 9:00am – 5:00pm"
    },
  ].obs;
   final List<Map<String, dynamic>> carouselOptions = [
    {
      'title': 'Māori & Pasifika Grants',
      'description': 'Targeted Support For Education, Whānau, And Housing.',
      'image': "assets/images/certification.png",
      'backgroundColor': Colors.white,
      'link':'https://www.studylink.govt.nz/',
    },
    {
      'title': 'Work And Income (WINZ)',
      'description': 'Apply For Hardship Grants, Support, Or Benefit Top-Up.',
      'image': "assets/images/www.png",
      'backgroundColor': Colors.white,
      'link':'https://www.workandincome.govt.nz/',
    },
    {
      'title': 'Another Support Option',
      'description': 'A brief description of this support service.',
      'image': "assets/images/www.png",
      'backgroundColor': Colors.white,
      'link':'https://www.communitymatters.govt.nz/',
    },
  ].obs;
   final List<Map<String, dynamic>> dailyTips = [
    {
      'tip' : 'Make A Grocery List Before Shopping Saves Average Of \$25/Week'
    },
    {
      'tip' :  'Free Breakfast Programs Available At Many Schools Check With Your Local Kura'
    },
    {
      'tip' : 'Keep Coins In A Jar Labeled bus Fare – It Adds Up',
    }
  ].obs;

   //Api binding for emergency form.
   Future<bool> emergencyRequestProcess() async {
     final address = addressControllerText.text;
     final emergencyType = selectedEmergencyId;
     final emergencySituation = situationControllerText.text;

     if (address.isEmpty) {
       message.value = 'Please enter your Address';
       return false;
     }
     if (emergencySituation.isEmpty) {
       message.value = 'Please Describe your Situation';
       return false;
     }



     final url = Uri.parse('${AppSettings.baseUrl}emergency-requests/create');
     final response = await http.post(url,
       headers: {
         'Content-Type': 'application/json',
         'Authorization': 'Bearer ${box.read('token')}',
       },
       body: jsonEncode({
         "address": address,
         "emergencyType": emergencyType,
         "explainYourSituation": emergencySituation,
         "status": 1,
       }),
     );
     if (response.statusCode == 201) {
       message.value = 'Emergency Request Sent Successfully..! \nAdmin will Contact you soon';
       return true;
     }
     else {
       message.value = 'Request Not Sent Try Again';
       return false;
     }
   }

}
