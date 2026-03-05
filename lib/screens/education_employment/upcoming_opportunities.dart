import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/seminar_and_events.dart';
import 'package:flutter/material.dart';

class UpcomingOpportunities extends StatefulWidget {
  const UpcomingOpportunities({super.key});

  @override
  State<UpcomingOpportunities> createState() => _UpcomingOpportunitiesState();
}

class _UpcomingOpportunitiesState extends State<UpcomingOpportunities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: const CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Upcoming Opportunities',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: false,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Stay informed about key dates, free courses, and events that matter to you.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFonts.secondaryFontFamily,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(child: SeminarAndEvents(category: [2])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
