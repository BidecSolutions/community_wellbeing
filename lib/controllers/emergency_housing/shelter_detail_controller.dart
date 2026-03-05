import 'package:get/get.dart';

class ShelterDetailController extends GetxController {
  var sliderItems = [
    {'image': 'assets/images/housing/shelter_image.png' },
    {'image': 'assets/images/housing/shelter_image.png'},
    {'image': 'assets/images/housing/shelter_image.png'},
  ].obs;

  var housingList = [
    {
      'title': 'Shelter Name',
      'bedrooms': '2 Bedroom',
      'location': 'House No. C-122, Block 7, University Road, . .',
      'date': '5 June',
      'description':
      'Hope House provides temporary emergency housing for women and families affected by violence or displacement. Staff are available 24/7.',
      'galleryImages': [
        'assets/images/housing/house_image.png',
        'assets/images/housing/house_image.png',
        'assets/images/housing/house_image.png',
        'assets/images/housing/house_image.png',
      ],
    },
  ].obs;
}
