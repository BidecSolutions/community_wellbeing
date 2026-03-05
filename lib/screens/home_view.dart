import 'package:community_app/screens/widgets/player.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_app/screens/widgets/grids.dart';
import 'package:community_app/app_settings/fonts.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  // final HomeController controller = Get.put(HomeController());
  // slider 1
  final List<Map<String, dynamic>> sliderItems = [
    {'image': 'assets/images/slider_1.png', 'label': 'Mental Health is Wealth'},
    {
      'image': 'assets/images/slider_2.png',
      'label': 'Housing',
    }, // blue background fallback
    {'image': 'assets/images/health_first.webp', 'label': 'Health Facts'},
  ];

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
      'title': 'Health & Wellbeing',
      'image': 'assets/images/health.cat.png',
      'color': const Color(0xFFFFF0CA),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/health',
    },
    {
      'title': 'Parents & Family',
      'image': 'assets/images/parenting.cat.png',
      'color': const Color(0xFFCDF7FF),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/parenting',
    },
    {
      'title': 'Expense Management',
      'image': 'assets/images/expense.cat.png',
      'color': const Color(0xFFDBCAFF),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/finance',
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
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/housing',
    },
    {
      'title': 'Education & Employment',
      'image': 'assets/images/education.cat.png',
      'color': const Color(0xFFFFCDDD),
      'imageColor': const Color(0xFFCDFFDA), // Example color
      'textColor': Color(0xFF000000),
      'link': '/education',
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
    {
      'title': 'History',
      'image': 'assets/images/preloved/preloved.png',
      'color': const Color(0xFFFFFEAD),
      'imageColor': const Color.fromARGB(255, 255, 179, 1),
      'textColor': Color(0xFF000000),
      'link': '/history',
    },
    {
      'title': 'E-Store',
      'image': 'assets/images/e_store/trolly.png',
      'color': const Color(0xFFBDBBFF),
      'imageColor': const Color(0xFFBDBBFF),
      'textColor': Color(0xFF000000),
      'link': '/eStore',
    },
  ];
  //what around me
  final List<Map<String, String>> whatAroundMeData1 = [
    {
      'label': 'Food Banks Near Me',
      'imagePath': 'assets/images/food_banks.webp',
      'link': 'https://www.google.com/maps/search/restaurants+near+me',
    },
    {
      'label': 'Physio Therapy clinic Near Me',
      'imagePath': 'assets/images/physio_clinic.jpg',
      'link': 'https://www.google.com/maps/search/hotels+near+me',
    },
    {
      'label': 'Swimming Pool Near Me',
      'imagePath': 'assets/images/swiming_pool.webp',
      'link': 'https://www.google.com/maps/search/restaurants+near+me',
    },
    {
      'label': 'Gym Near Me',
      'imagePath': 'assets/images/gym.webp',
      'link': 'https://www.google.com/maps/search/hotels+near+me',
    },
  ];
  final List<Map<String, String>> whatAroundMeData2 = [
    {
      'label': 'Rewards & Perks',
      'imagePath': 'assets/images/rewards.png',
      'link': 'https://www.google.com/maps/search/restaurants+near+me',
    },
    {
      'label': 'Personal Wellbeing',
      'imagePath': 'assets/images/pbj.png',
      'link': 'https://www.google.com/maps/search/hotels+near+me',
    },
    {
      'label': 'Physical Therapy',
      'imagePath': 'assets/images/physical therapy.png',
      'link': 'https://www.google.com/maps/search/restaurants+near+me',
    },
    {
      'label': 'Youth Programs',
      'imagePath': 'assets/images/yp.png',
      'link': 'https://www.google.com/maps/search/hotels+near+me',
    },
  ];
  //Your Schedule
  final List<Map<String, dynamic>> yourScheduleData = [
    {
      'title': 'Cardiology',
      'image': 'assets/images/dr_img.png',
      'avatar_name': 'Cardiology',
      'avatar_data': 'Dr. Sergej',
      'link':
          'https://www.google.com/maps/search/restaurants+near+me', //replace
      'tag': 'Doctor',
      'date': '25 May,',
      'time': '14:00-15:00',
      'tagBgColor': Colors.white54,
      'color': Color(0xFFFFF0CA),
    },
    {
      'title': 'Matariki celebrations',
      'image': 'assets/images/location.png', // Replace
      'avatar_name': 'Location',
      'avatar_data': 'Loreum..',
      'link': 'https://www.google.com/maps/search/hotels+near+me', //replace
      'tag': 'Event',
      'tagBgColor': Colors.white54,
      'date': '25 May,',
      'time': '14:00-15:00',
      'color': Color(0xFFD5EBFF),
    },
    {
      'title': 'Yami Sounz Summit',
      'image': 'assets/images/location.png', // Replace
      'avatar_name': 'Location',
      'avatar_data': 'Loreum..',
      'link':
          'https://www.google.com/maps/search/restaurants+near+me', //replace
      'tag': 'Seminar',
      'tagBgColor': Colors.white54,
      'date': '25 May,',
      'time': '14:00-15:00',
      'color': Color(0xFFFEDBDF),
    },
    {
      'title': 'Matariki celebrations',
      'image': 'assets/images/location.png', // Replace
      'avatar_name': 'Location',
      'avatar_data': 'Loreum..',
      'link': 'https://www.google.com/maps/search/hotels+near+me', //replace
      'tag': 'Event',
      'tagBgColor': Colors.white54,
      'date': '25 May,',
      'time': '14:00-15:00',
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
                showNotificationIcon: true,
                showMenuIcon: true,
                showBackIcon: false,
                showBottom: true,
                userName: true,
                screenName: "",
              ),
              //--- slider start --
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
                                                color: Colors.black.withValues(
                                                  alpha: 0.5,
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
              // ElevatedButton(
              //   onPressed: () {
              //     throw Exception();
              //   },
              //   child: Text("Test Crash"),
              // ),
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
                      fontSize: 20.0,
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
                child: Wrap(
                  spacing: 16,
                  runSpacing: 20,
                  children:
                      categories.map((category) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, category['link']);
                            // Or use Get.toNamed(category['link']); if you're using GetX routing
                          },
                          child: SizedBox(
                            width:
                                MediaQuery.of(context).size.width / 4 -
                                25, // 4 per row
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
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: category['textColor'],
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),

              // --- End of category display UI ---
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 10.0,
                  bottom: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  children: [
                    WhatAroundMeSection(
                      title: "Your Journey Hub",
                      gridItems: whatAroundMeData2,
                    ), // Your Journey Hub
                    // Start updates from community
                    SizedBox(height: 20),
                    SizedBox(
                      // Added a Container
                      width:
                          double.infinity, // Make the container take full width
                      child: Text(
                        'Updates From Community',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily:
                              AppFonts.secondaryFontFamily, // Use your font
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: [
                        Card(
                          elevation: 0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                    8,
                                  ), // Optional padding around the image
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFCDFFDA),
                                  ),
                                  child: Image.asset(
                                    "assets/images/weather.upd.png",
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weather Alert',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                        ),
                                      ),
                                      Text(
                                        'Cyclone Expected in Northland',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                    8,
                                  ), // Optional padding around the image
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD5EBFF),
                                  ),
                                  child: Image.asset(
                                    "assets/images/newpetition.upd.png",
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'New Petition',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                        ),
                                      ),
                                      Text(
                                        'More Funding For Maori health ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Card(
                          elevation: 0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                    8,
                                  ), // Optional padding around the image
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF0CA),
                                  ),
                                  child: Image.asset(
                                    "assets/images/workshop.upd.png",
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Work Shop',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                        ),
                                      ),
                                      Text(
                                        'Free budgeting class for families',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: 20),

                    // Your Schedule Section start
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 20.0,
                        bottom: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Your Schedule',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.secondaryFontFamily,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: 'Today',
                                iconSize: 12,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                                items:
                                    <String>[
                                      'Today',
                                      'Tomorrow',
                                      'This Week',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  // handle dropdown change
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent:
                                null, // Adjust this height to fit your content
                          ),
                      itemCount: yourScheduleData.length,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> option =
                            yourScheduleData[index];

                        return GestureDetector(
                          onTap: () {
                            // handle tap
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: option['color'],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Tag
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: option['tagBgColor'],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    option['tag'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Title
                                Text(
                                  option['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // Date
                                Text(
                                  option['date'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                  ),
                                ),

                                // Time
                                Text(
                                  option['time'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
                                    fontFamily: 'Roboto',
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Bottom Row with Avatar + Name/Data
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.white,
                                      child: Image.asset(
                                        option['image'],
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            option['avatar_name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              fontFamily: 'Roboto',
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            option['avatar_data'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              fontFamily: 'Roboto',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),


                    // --- End of Your Schedule--
                    SizedBox(height: 20),
                    // --- Start of Blank Section--
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 150.0,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                      ),
                      items:
                          imageItems.map((item) {
                            final String? imagePath = item['image'];
                            final String? label = item['label'];

                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    imagePath == null
                                        ? Colors.lightBlueAccent
                                        : null,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child:
                                    imagePath != null
                                        ? Stack(
                                          children: [
                                            Image.asset(
                                              imagePath,
                                              width: double.infinity,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
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
                                                    color: Colors.black
                                                        .withValues(alpha: 0.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    label,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        )
                                        : const SizedBox.expand(), // fills container with blue if no image
                              ),
                            );
                          }).toList(),
                    ),

                    // --- End of Blank Section--
                    // --- Your Recent Activity Start --
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Your Recent Activity',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily:
                                AppFonts.secondaryFontFamily, // Use your font
                          ),
                        ),
                        Obx(() {
                          final carouselOptions = controller.yourActivity;
                          return SizedBox(
                            height: 200,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: carouselOptions.length,
                              separatorBuilder:
                                  (context, index) => const SizedBox(width: 16),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemBuilder: (context, index) {
                                final option = carouselOptions[index];
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (option['image'] != null)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                option['image'],
                                                width: double.infinity,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                bottom: 8,
                                                left: 8,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                  // decoration: BoxDecoration(
                                                  //   color: Colors.black.withOpacity(0.6),
                                                  //   borderRadius: BorderRadius.circular(6),
                                                  // ),
                                                  child: Text(
                                                    option['label'] ?? 'Label',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                    // --- Your Recent Activity End --
                    SizedBox(height: 10),
                    //Whats around me section start
                    WhatAroundMeSection(
                      title: "What's Around Me",
                      gridItems: whatAroundMeData1,
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Center(
                          // Wrap the Text widget with a Center widget
                          child: Text(
                            "Moments Of Change",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              fontFamily:
                                  AppFonts.secondaryFontFamily, // Use your font
                            ),
                          ),
                        ),
                      ),
                    ),
                    Player(),

                    const SizedBox(height: 20),

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
}
