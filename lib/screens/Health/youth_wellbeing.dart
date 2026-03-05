import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../app_settings/fonts.dart';
import '../../app_settings/settings.dart';
import '../../controllers/health/youth_wellbeing_controller.dart';
import '../widgets/drawer.dart';

class YouthWellbeing extends StatefulWidget {
  const YouthWellbeing({super.key});
  @override
  State<YouthWellbeing> createState() => _YouthWellbeingState();
}

class _YouthWellbeingState extends State<YouthWellbeing> {
  final YouthWellbeingController controller = Get.put(
    YouthWellbeingController(),
  );
  @override
  void initState() {
    super.initState();
    controller.fetchYouthWellBegin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar(
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Youth Wellbeing',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
                profile: true,
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.grey,
                thickness: 1,      // height of the line
                indent: 20,        // left space
                endIndent: 20,     // right space
              ),
              //--- App bar end --
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        'How Are You Feeling',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 25),
                      //--- horizontal scroll start--
                      Obx(
                        () => SizedBox(
                          height: 80,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.items.length,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final item = controller.items[index];

                              return Obx(() {
                                final isSelected =
                                    controller.selectedIndex.value == index;

                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedIndex.value = index;
                                  },
                                  child: Container(
                                    width: 250,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.all(8),
                                          child: Image.network(
                                            AppSettings.baseUrl + item['image'],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item['text'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: AppFonts
                                                      .primaryFontFamily,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                item['description'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: AppFonts
                                                      .primaryFontFamily,
                                                  fontWeight: FontWeight.w200,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      // list to treat
                      Obx(() {
                        if (controller.items.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // Check selectedIndex is in range
                        if (controller.selectedIndex.value >=
                            controller.items.length) {
                          return const SizedBox(); // or reset to 0, or show fallback
                        }
                        final bullets =
                            controller.items[controller
                                    .selectedIndex
                                    .value]['bullets']
                                as List<String>;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: bullets
                                  .map(
                                    (bullet) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "• ",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Expanded(
                                            child: Text(
                                              bullet,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      }),

                      //--- horizontal scroll end--

                      //---not feeling ok start--
                      // const SizedBox(height: 25),
                      // const Padding(
                      //   padding: EdgeInsets.all(20.0),
                      //   child: Align(
                      //     alignment: Alignment.center,
                      //     child: Text(
                      //       'Not Feeling Ok?',
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 22,
                      //         fontFamily: AppFonts.secondaryFontFamily,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 0),
                      //   child: Column(
                      //     children: [
                      //       // Two half width grids 1st
                      //       IntrinsicHeight(
                      //         child: Row(
                      //           children: [
                      //             // call start
                      //             Expanded(
                      //               child: Container(
                      //                 padding: const EdgeInsets.all(30),
                      //                 decoration: BoxDecoration(
                      //                   color: Color(0xFFFFF0CA),
                      //                   borderRadius: BorderRadius.circular(12),
                      //                 ),
                      //                 child: Column(
                      //                   children: [
                      //                     Image.asset(
                      //                       'assets/images/health/talk_to_someone.png',
                      //                       height: 50,
                      //                       fit: BoxFit.contain,
                      //                     ),
                      //                     const SizedBox(height: 18),
                      //                     Text(
                      //                       'Talk To Someone',
                      //                       textAlign: TextAlign.center,
                      //                       style: TextStyle(
                      //                         fontFamily:
                      //                             AppFonts.primaryFontFamily,
                      //                         fontWeight: FontWeight.w400,
                      //                         fontSize: 16,
                      //                         color: Colors.black,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //
                      //             // call end
                      //             const SizedBox(width: 16),
                      //             // not sure start
                      //             Expanded(
                      //               child: GestureDetector(
                      //                 onTap: () {
                      //                   // Get.toNamed('/not_sure');
                      //                 },
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(30),
                      //                   decoration: BoxDecoration(
                      //                     color: Color(0xFFD5EBFF),
                      //                     borderRadius: BorderRadius.circular(
                      //                       12,
                      //                     ),
                      //                   ),
                      //                   child: Column(
                      //                     children: [
                      //                       Image.asset(
                      //                         'assets/images/health/youth_group.png',
                      //                         height: 50,
                      //                         fit: BoxFit.contain,
                      //                       ),
                      //                       const SizedBox(height: 18),
                      //                       Text(
                      //                         'Youth Group',
                      //                         textAlign: TextAlign.center,
                      //                         style: TextStyle(
                      //                           fontFamily:
                      //                               AppFonts.primaryFontFamily,
                      //                           fontWeight: FontWeight.w400,
                      //                           fontSize: 16,
                      //                           color: Colors.black,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             // not sure end
                      //           ],
                      //         ),
                      //       ),
                      //
                      //       // Two half width grids 1st end
                      //     ],
                      //   ),
                      // ),
                      //--- Trusted Repair Services start --
                      const SizedBox(height: 45),
                      Container(
                        width: double.infinity,
                        height: 150, // Set your desired height
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD5EBFF), Color(0xFFF5F5F0)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.0, 0.6],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Your Story Isn’t Over Yet \nYou’re Just Getting Started',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                        ),
                      ),
                      //---Not Feeling Ok end--

                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Fun Whānau Challenges',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                        ),
                      ),

                      Obx(
                        () => SizedBox(
                          height: 235,

                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                controller.challenges.length,
                                (index) {
                                  final challenge =
                                      controller.challenges[index];

                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Emoji/image container
                                          Container(
                                            width: 60,
                                            height: 60,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: challenge['bgColor'],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Image.asset(
                                              challenge['image'],
                                              fit: BoxFit.contain,
                                            ),
                                          ),

                                          const SizedBox(height: 12),

                                          // Title Row with fixed height
                                          SizedBox(
                                            height: 50,
                                            child: Center(
                                              child: Text(
                                                challenge['title'],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 15),

                                          // Description Row with fixed height
                                          SizedBox(
                                            height: 50,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    challenge['description'],
                                                    style: const TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 18,
                                                  height: 18,
                                                  margin: const EdgeInsets.only(
                                                    left: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                  ),
                                                  child: Obx(
                                                    () => Checkbox(
                                                      value:
                                                          challenge['checked']
                                                              .value,
                                                      onChanged: (val) {
                                                        challenge['checked']
                                                                .value =
                                                            val ?? false;
                                                      },
                                                      activeColor: Colors.green,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
