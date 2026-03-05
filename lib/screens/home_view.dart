import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:community_app/screens/widgets/grids.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  // final HomeController controller = Get.put(HomeController());
  // slider 1
  final List<Map<String, dynamic>> sliderItems = [
    {'image': 'assets/images/slider_1.png', 'label': 'Mental Health is Wealth'},
    {
      'image': 'assets/images/slider_2.png',
      'label': 'housing',
    }, // blue background fallback
    {'image': 'assets/images/health_first.webp', 'label': 'Health facts'},
  ];
  final List<String> videoIds = ['ElVw2WE1PR8', '5rhHm6WWOIs', 'xfOT2elC2Ok'];
  // category
  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Social Support',
      'image': 'assets/images/social.cat.png',
      'color': const Color(0xFFCDFFDA),
      'imageColor': const Color(0xFF00A72D),
      'textColor': Color(0xFF000000),
      'link': '/social_support',
    },
    {
      'title': 'Food Support',
      'image': 'assets/images/food.cat.png',
      'color': const Color(0xFFF9CDFF),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/food_support',
    },
    {
      'title': 'Housing Quality',
      'image': 'assets/images/house.cat.png',
      'color': const Color(0xFFFFE1E2),
      'imageColor': const Color(0xFFCDFFDA),
      'textColor': Color(0xFF000000),
      'link': '/housing',
    },
    {
      'title': 'Expense Management',
      'image': 'assets/images/expense.cat.png',
      'color': const Color(0xFFDBCAFF),
      'imageColor': const Color(0xFFCDFFDA),
      'textColor': Color(0xFF000000),
      'link': '/finance',
    },
    {
      'title': 'Parents & Family',
      'image': 'assets/images/parenting.cat.png',
      'color': const Color(0xFFCDF7FF),
      'imageColor': const Color(0xFFCDFFDA),
      'textColor': Color(0xFF000000),
      'link': '/parenting',
    },
    {
      'title': 'Apply For Help',
      'image': 'assets/images/apply.cat.png',
      'color': const Color(0xFFFFFECD),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/apply_for_help',
    },
    {
      'title': 'Emergency Housing',
      'image': 'assets/images/emergency.cat.png',
      'color': const Color(0xFFCAE7FF),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/emergency_housing',
    },
    {
      'title': 'Health & Wellbeing',
      'image': 'assets/images/health.cat.png',
      'color': const Color(0xFFFFF0CA),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/health',
    },
    {
      'title': 'IT Support & Electronic',
      'image': 'assets/images/it.cat.png',
      'color': const Color(0xFFEAFFCD),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/internet_support',
    },
    {
      'title': 'Justice & Safety',
      'image': 'assets/images/justice.cat.png',
      'color': const Color(0xFFD0FFCA),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/justice_n_safety',
    },
    {
      'title': 'Culture & Employment',
      'image': 'assets/images/culture.cat.png',
      'color': const Color(0xFFE1FFFA),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/culture_community',
    },
    {
      'title': 'Disability Support',
      'image': 'assets/images/disability/disability.png',
      'color': const Color(0xFFD5EBFF),
      'imageColor': const Color(0xFFCDFFDA),
      'textColor': Color(0xFF000000),
      'link': '/disability_support',
    },
    {
      'title': 'Pre-Loved',
      'image': 'assets/images/preloved/preloved.png',
      'color': const Color(0xFFFFFEAD),
      'imageColor': const Color.fromARGB(255, 255, 179, 1),
      'textColor': Color(0xFF000000),
      'link': '/pre_loved',
    },
  ];
  //what around me
  final List<Map<String, String>> whatAroundMeData1 = [
    {
      'label': 'Food Banks',
      'imagePath': 'assets/images/food_banks.webp',
      'link': 'https://www.google.com/maps/search/restaurants+near+me',
    },
    {
      'label': 'Physio Therapy clinic',
      'imagePath': 'assets/images/physio_clinic.jpg',
      'link': 'https://www.google.com/maps/search/hotels+near+me',
    },
    {
      'label': 'Swimming Pool',
      'imagePath': 'assets/images/swiming_pool.webp',
      'link': 'https://www.google.com/maps/search/restaurants+near+me',
    },
    {
      'label': 'Gym',
      'imagePath': 'assets/images/gym.webp',
      'link': 'https://www.google.com/maps/search/hotels+near+me',
    },
  ];
  final List<Map<String, String>> whatAroundMeData2 = [
    {
      'label': 'Rewards & Perks',
      'imagePath': 'assets/images/rewards.png',
      'link': '/rewards_perks',
    },
    {
      'label': 'Personal Wellbeing',
      'imagePath': 'assets/images/pbj.png',
      'link': '/personal',
    },
    {
      'label': 'Physical Therapy',
      'imagePath': 'assets/images/physical therapy.png',
      'link': '/physical_therapy',
    },
    {
      'label': 'Youth Programs',
      'imagePath': 'assets/images/yp.png',
      'link': '/youth_program',
    },
  ];
  //Your Schedule
  final List<Map<String, dynamic>> yourScheduleData = [
    {
      'title': 'Caridology',
      'image': 'assets/images/dr_img.png',
      'avatar_name': 'Cardiology',
      'avatar_data': 'Dr. Sergej',
      'link':
      'https://www.google.com/maps/search/restaurants+near+me', //replace
      'tag': 'Doctor',
      'date': '25 July,',
      'time': '4:00-5:00 PM',
      'tagBgColor': Colors.white54,
      'color': Color(0xFFFFF0CA),
    },
    {
      'title': 'Matariki celebrations',
      'image': 'assets/images/location.png', // Replace
      'avatar_name': 'Location',
      'avatar_data': 'Wanaka',
      'link': 'https://www.google.com/maps/search/hotels+near+me', //replace
      'tag': 'Event',
      'tagBgColor': Colors.white54,
      'date': '15 july,',
      'time': '01:00-04:00 PM',
      'color': Color(0xFFD5EBFF),
    },
    {
      'title': 'Yami Sounz Summit',
      'image': 'assets/images/location.png', // Replace
      'avatar_name': 'Location',
      'avatar_data': 'Wanaka',
      'link':
      'https://www.google.com/maps/search/restaurants+near+me', //replace
      'tag': 'Seminar',
      'tagBgColor': Colors.white54,
      'date': '23 July,',
      'time': '10:00-11:00 AM',
      'color': Color(0xFFFEDBDF),
    },
    {
      'title': 'Matariki celebrations',
      'image': 'assets/images/location.png', // Replace
      'avatar_name': 'Location',
      'avatar_data': 'Wanaka',
      'link': 'https://www.google.com/maps/search/hotels+near+me', //replace
      'tag': 'Event',
      'tagBgColor': Colors.white54,
      'date': '09 July,',
      'time': '08:00-10:00 PM',
      'color': Color(0xFFE1DDFF),
    },
  ];
  final List<Map<String, dynamic>> imageItems = [
    {'image': 'assets/images/scholarship.png'},
    {'image': 'assets/images/good_invest.jpg'}, // Will show blue background
    {'image': 'assets/images/2_banner.webp'},
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: const Color(0xFFF5F5F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar(
                showNotificationIcon: false,
                profile: true,
                showMenuIcon: false,
                showBackIcon: false,
                showBottom: false,
                userName: true,
                screenName: "",
              ),
              //--- slider start --
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                  ),
                  items:
                  sliderItems.map((item) {
                    final image = item['image'];
                    final label = item['label'];

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: image == null ? Colors.blue : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:
                        image != null
                            ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(image, fit: BoxFit.cover),
                            if (label != null)
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(
                                      0.5,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    label,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                            : const SizedBox.expand(),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // --- end of slider --
              // --- Start of category display UI ---
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 20.0,
                  bottom: 10.0,
                ), // Added padding
                child: Align(
                  alignment: Alignment.center, // Align text to the left
                  child: Text(
                    'All The Support You Need',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.secondaryFontFamily, // Use your font
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  top: 20.0,
                  right: 10.0,
                  bottom: 10.0,
                ),
                child: Column(
                  children: [
                    // First full rows
                    for (int i = 0; i < (categories.length / 4).floor(); i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (j) {
                          final index = i * 4 + j;
                          final category = categories[index];
                          return _buildCategoryItem(context, category);
                        }),
                      ),

                    // Last row with 1 or 2 items (centered)
                    if (categories.length % 4 != 0)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(categories.length % 4, (j) {
                          final index = (categories.length / 4).floor() * 4 + j;
                          final category = categories[index];
                          return _buildCategoryItem(context, category);
                        }),
                      ),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 10.0,
                  bottom: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    GestureDetector(
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              Image.asset("assets/images/budget.png"),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Budget planner',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: AppFonts.primaryFontFamily,
                                      ),
                                    ),
                                    Text(
                                      'Plan where your money goes each week. Simple, smart, and free to use.',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: AppFonts.primaryFontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.toNamed('budget-management');
                      },
                    ),
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Center(
                          // Wrap the Text widget with a Center widget
                          child: Text(
                            "Moments Of Change",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              fontFamily:
                              AppFonts.secondaryFontFamily, // Use your font
                            ),
                          ),
                        ),
                      ),
                    ),
                    Player(),

                    //video slider end
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
  Widget _buildCategoryItem(BuildContext context, Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, category['link']);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4 - 25,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: category['color'],
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    category['image'],
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                category['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: category['textColor'],
                  fontSize: 11,
                  fontFamily: AppFonts.primaryFontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
