import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/health/all_problems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../app_settings/fonts.dart';
import '../widgets/drawer.dart';

class KnowWhatToDoWhenSick extends StatefulWidget {
  const KnowWhatToDoWhenSick({super.key});

  @override
  State<KnowWhatToDoWhenSick> createState() => _KnowWhatToDoWhenSickState();
}

class _KnowWhatToDoWhenSickState extends State<KnowWhatToDoWhenSick> {
  // final KnowWhatToDoWhenSickController controller = Get.put(
  //   KnowWhatToDoWhenSickController(),
  // );
  final ProblemController problemController = Get.put(ProblemController());

  @override
  void initState() {
    super.initState();
    problemController.fetchProblems();
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
                screenName: 'Know What To Do When Sick',
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
                        'Okay To Treat At Home',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 25),

                      //--- horizontal scroll start--
                      Obx(() {
                        return SizedBox(
                          height: 70,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: problemController.problems.length,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            separatorBuilder:
                                (context, index) => const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final problem = problemController.problems[index];
                              return Obx(() {
                                final isSelected =
                                    problemController.selectedIndex.value ==
                                    index;

                                return GestureDetector(
                                  onTap: () {
                                    problemController.selectedIndex.value =
                                        index;
                                    problemController.solutions(
                                      id: problem.id,
                                    );
                                  },
                                  child: Container(
                                    width: 250,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? AppColors.primaryColor
                                                : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: problem.color,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                AppSettings.baseUrl +
                                                problem.icons,
                                            fit: BoxFit.contain,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error_outline),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            problem.problemName,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        );
                      }),

                      const SizedBox(height: 20),
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child:
                                problemController.solutionsList.isEmpty
                                    ? Center(
                                      child: Text(
                                        'Select a problem to see solutions',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              AppFonts.primaryFontFamily,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                    : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          problemController.solutionsList
                                              .map(
                                                (solution) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        bottom: 8,
                                                      ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "• ",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          solution.name,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                AppFonts
                                                                    .primaryFontFamily,
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

                      // Obx(() {
                      //   final bullets =
                      //       controller.items[controller
                      //               .selectedIndex
                      //               .value]['bullets']
                      //           as List<String>;

                      //   return Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 0),
                      //     child: Container(
                      //       width: double.infinity,
                      //       padding: const EdgeInsets.all(16),
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(16),
                      //       ),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children:
                      //             bullets
                      //                 .map(
                      //                   (bullet) => Padding(
                      //                     padding: const EdgeInsets.only(
                      //                       bottom: 8,
                      //                     ),
                      //                     child: Row(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         const Text(
                      //                           "•",
                      //                           style: TextStyle(fontSize: 16),
                      //                         ),
                      //                         Expanded(
                      //                           child: Text(
                      //                             bullet,
                      //                             style: TextStyle(
                      //                               fontSize: 14,
                      //                               fontFamily:
                      //                                   AppFonts
                      //                                       .primaryFontFamily,
                      //                               color: Colors.black,
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 )
                      //                 .toList(),
                      //       ),
                      //     ),
                      //   );
                      // }),

                      //--- horizontal scroll end--
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Talk to a Nurse or Doctor If',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Fever lasts more than 3 days",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Pain doesn't go away",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "You feel worse after getting better",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "• ",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Child won’t eat or drink",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // Center(
                      //   child: SizedBox(
                      //     width: 150,
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         Get.toNamed('/home_repair_support');
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: AppColors.primaryColor,
                      //         padding: const EdgeInsets.symmetric(vertical: 12),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //       ),
                      //       child: const Text(
                      //         'Call Healthline',
                      //         style: TextStyle(
                      //           fontFamily: AppFonts.primaryFontFamily,
                      //           fontSize: 12,
                      //           // fontWeight: FontWeight.bold,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      //---see a doctor if you notice start--
                      const SizedBox(height: 25),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'See a Doctor If You Notice:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              fontFamily: AppFonts.secondaryFontFamily,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: [
                            // Two half width grids 1st
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  // call start
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF0CA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/health/chest_pain.png',
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 18),
                                          Text(
                                            'Persistent chest pain',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.primaryFontFamily,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // call end
                                  const SizedBox(width: 16),
                                  // not sure start
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Get.toNamed('/not_sure');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFD5EBFF),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/health/trouble_breathing.png',
                                              height: 50,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 18),
                                            Text(
                                              'Trouble breathing',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // not sure end
                                ],
                              ),
                            ),
                            // Two half width grids 1st end
                            const SizedBox(height: 16),
                            // two half grid 2nd start
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  // call start
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Get.toNamed('/someone_know');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFCDFFDA),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/health/dehydration.png',
                                              height: 50,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Severe vomiting or dehydration',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // call end
                                  const SizedBox(width: 16),
                                  // not sure start
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/care_options');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(30),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFEDBDF),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/images/health/rash_spread.png',
                                              height: 50,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 25),
                                            Text(
                                              'Rash that spreads or won’t fade',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    AppFonts.primaryFontFamily,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // not sure end
                                ],
                              ),
                            ),
                            // Two half width grids 2nd end
                          ],
                        ),
                      ),
                      // const SizedBox(height: 20),
                      // Center(
                      //   child: SizedBox(
                      //     width: 150,
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         Get.toNamed('/home_repair_support');
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: AppColors.primaryColor,
                      //         padding: const EdgeInsets.symmetric(vertical: 12),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //       ),
                      //       child: const Text(
                      //         'Find Clinic Near You',
                      //         style: TextStyle(
                      //           fontFamily: AppFonts.primaryFontFamily,
                      //           fontSize: 12,
                      //           // fontWeight: FontWeight.bold,
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //---see a doctor if you notice end--
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
