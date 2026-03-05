import 'package:get/get.dart';

class AvailableShelterController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  void setLocation(double lat, double long) {
    latitude.value = lat;
    longitude.value = long;

    // Optional: Call API or update housing list here
    // fetchNearbyShelters(lat, long);
  }

  var housingList =
      [
        {
          'image': 'assets/images/housing/house_image.png',
          'title': 'Shelter Name',
          'bedrooms': '2 Bedroom',
          'location': 'House No. C-122, Block 7, University Road , . .',
        },
        {
          'image': 'assets/images/housing/house_image.png',
          'title': 'Shelter Name',
          'bedrooms': '1 Bedroom',
          'location': 'House No. C-122, Block 7, University Road , . .',
        },
        {
          'image': 'assets/images/housing/house_image.png',
          'title': 'Shelter Name',
          'bedrooms': '4 Bedroom',
          'location': 'House No. C-122, Block 7, University Road , . .',
        },
        {
          'image': 'assets/images/housing/house_image.png',
          'title': 'Shelter Name',
          'bedrooms': '3 Bedroom',
          'location': 'House No. C-122, Block 7, University Road , . .',
        },
      ].obs;
}
