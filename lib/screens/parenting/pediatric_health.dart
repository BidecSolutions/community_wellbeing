import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/colors.dart';
import '../../app_settings/fonts.dart';
import '../../controllers/parenting/cultural_specific_controller.dart';
import '../widgets/drawer.dart';


class PediatricHealth extends StatelessWidget {
  PediatricHealth({super.key});

  final CulturalSpecificController controller = Get.put(
    CulturalSpecificController(),
  );

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
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Pediatric & Health Check \nReminders',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
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
                        ' Well-Child Visits Timeline',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'A clear list of when to take your child for routine checkups.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: AppFonts.primaryFontFamily,
                          color: Color(0xFF4C4C4C),
                        ),
                      ),

                      //--- table start --
                      const SizedBox(height: 20),
                      Table(
                        // border: TableBorder.all(color: Colors.grey.shade300),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(1.5),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(3),
                        },
                        children: [
                          // Header
                          TableRow(
                            // decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Age',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Recommended \nVisit',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'What’s \nChecked',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          _buildRow(
                            '0–2 weeks',
                            'Newborn check',
                            'Weight, feeding, jaundice',
                          ),
                          _buildRow(
                            '6–8 weeks',
                            'First immunizations',
                            'Physical exam, shots',
                          ),
                          _buildRow(
                            '3–4 months',
                            'Growth check',
                            'Head shape, tummy time tips',
                          ),
                          _buildRow(
                            '6 months',
                            'Development check',
                            'Sitting, hearing, solids',
                          ),
                          _buildRow(
                            '9 months',
                            'Mobility review',
                            'Crawling, early words',
                          ),
                          _buildRow(
                            '12 months',
                            '1-year exam',
                            'Walking, vaccinations',
                          ),
                          _buildRow(
                            '18 months',
                            'Toddler development',
                            'Talking, behavior',
                          ),
                          _buildRow(
                            '2 years',
                            'Full check-up',
                            'Speech, coordination',
                          ),
                          _buildRow(
                            '3–5 years',
                            'Preschool prep',
                            'Vision, hearing, school readiness',
                          ),
                        ],
                      ),
                      //--- table end --

                      //--- stay on track start--
                      const SizedBox(height: 25),
                      Text(
                        ' Stay on Track with Vaccines',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 12),
                      //--- stay on track end--
                      //--- vaccine table start --
                      Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                        },
                        children: [
                          // Header row (no background)
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Age',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Vaccine',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),

                          _vaccineRow('6 weeks', 'DTP, Polio, Hep B, Hib', true),
                          _vaccineRow('3 months', '2nd dose group', false),
                          _vaccineRow('5 months', '3rd dose group', true),
                          _vaccineRow('12 months', 'MMR, Chickenpox', false),
                          _vaccineRow('4 years', 'Booster shots (DTP, MMR)', true),
                        ],
                      ),
                      //--- vaccine table end --

                      //--- Track Growth & Milestones start --


                      //--- Track Growth & Milestones start --
                      const SizedBox(height: 30),
                      Text(
                        ' Track Growth & Milestones',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Early checks can help identify delays in speech, hearing, movement, or social behavior—so your child gets the right support early.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: AppFonts.primaryFontFamily,
                          color: Color(0xFF4C4C4C),
                        ),
                      ),
                      const SizedBox(height: 30),
                      //--- Track Growth & Milestones end --
                       Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/parenting/check_at_2.png',
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Language Check at 2 Years',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                      AppFonts.secondaryFontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Ask your doctor if your toddler is speaking enough words and combining them properly.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                      AppFonts.secondaryFontFamily,
                                      fontSize: 13,
                                      color: Color(0xFF4C4C4C),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/parenting/hearing_test.png',
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Hearing Tests',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                      AppFonts.secondaryFontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 2),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("• ", style: TextStyle(fontSize: 16)),
                                              Expanded(
                                                child: Text(
                                                  "At 1 month (typically done at birth hospitals)",
                                                  style: TextStyle(fontSize: 14, color: AppColors.hintColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("• ", style: TextStyle(fontSize: 16)),
                                              Expanded(
                                                child: Text(
                                                  "Again at 3–4 years before school starts",
                                                  style: TextStyle(fontSize: 14, color: AppColors.hintColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),


                                ],
                              ),
                            ),
                          ),



                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/parenting/autism.png',
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Autism Screening at 18–24 Months',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                      AppFonts.secondaryFontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tools like the M-CHAT-R can help spot early signs of autism spectrum disorder.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                      AppFonts.secondaryFontFamily,
                                      fontSize: 13,
                                      color: Color(0xFF4C4C4C),
                                    ),
                                  ),
                                  const SizedBox(height: 10),


                                ],
                              ),
                            ),
                          ),



                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/parenting/vision.png',
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Vision Test Around 3–4 Years',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                      AppFonts.secondaryFontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Helps catch lazy eye or other vision problems before school age.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily:
                                      AppFonts.secondaryFontFamily,
                                      fontSize: 13,
                                      color: Color(0xFF4C4C4C),
                                    ),
                                  ),
                                  const SizedBox(height: 10),


                                ],
                              ),
                            ),
                          ),



                        ],
                      ),
                      //--- warning signs to watch for start --
                      const SizedBox(height: 30),
                      Text(
                        ' Warning Signs to Watch For',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.secondaryFontFamily,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Know when to take action — trust your instincts and consult a doctor if something feels off.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: AppFonts.primaryFontFamily,
                          color: Color(0xFF4C4C4C),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("• ", style: TextStyle(fontSize: 16)),
                                  Expanded(
                                    child: Text(
                                      "High fever that doesn’t go down",
                                      style: TextStyle(fontSize: 14, color: AppColors.hintColor),
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
                                  const Text("• ", style: TextStyle(fontSize: 16)),
                                  Expanded(
                                    child: Text(
                                      "No babbling by 12 months",
                                      style: TextStyle(fontSize: 14, color: AppColors.hintColor),
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
                                  const Text("• ", style: TextStyle(fontSize: 16)),
                                  Expanded(
                                    child: Text(
                                      "Not walking by 18 months",
                                      style: TextStyle(fontSize: 14, color: AppColors.hintColor),
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
                                  const Text("• ", style: TextStyle(fontSize: 16)),
                                  Expanded(
                                    child: Text(
                                      "Ongoing feeding or sleep issues",
                                      style: TextStyle(fontSize: 14, color: AppColors.hintColor),
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
                                  const Text("• ", style: TextStyle(fontSize: 16)),
                                  Expanded(
                                    child: Text(
                                      "Skin rashes, lethargy, or breathing trouble",
                                      style: TextStyle(fontSize: 14, color: AppColors.hintColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      //--- warning signs to watch for end --
                      // books session button--
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {

                          Get.toNamed('/find_a_provider');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Book Session',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
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

  TableRow _buildRow(String age, String visit, String checked) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(12), child: Text(textAlign: TextAlign.center,age)),
        Padding(padding: const EdgeInsets.all(12), child: Text(textAlign: TextAlign.center,visit)),
        Padding(padding: const EdgeInsets.all(12), child: Text(textAlign: TextAlign.center,checked)),
      ],
    );
  }

  // vaccine table
  TableRow _vaccineRow(String age, String vaccine, bool hasBackground) {
    return TableRow(
      decoration: hasBackground
          ? BoxDecoration(color: Colors.grey.shade200)
          : null,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(age),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            vaccine,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

}
