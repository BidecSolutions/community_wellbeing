import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
              /* ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Privacy Policy',
                showBottom: false,
                userName: false,
                showNotificationIcon: false,
              ),

              /* ─────────── App-bar End ─────────── */
              Padding(
                padding: const EdgeInsets.all(20),
                // const SizedBox(height: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // Privacy policy content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // content start here
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Effective Date: 27-May-2025\nApp Name: TE POU HIHIRI \nDeveloper: Ake Group Limited',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                AppFonts.primaryFontFamily,
                                            color: Colors.black,
                                            height: 1.5,
                                          ),
                                        ),

                                        SizedBox(height: 20),
                                        _sectionHeading(
                                          '1. Information We Collect',
                                        ),
                                        _paragraph(
                                          'When you use our app, we may collect the following personal data:',
                                        ),
                                        _bullet(
                                          'Sign Up: Name, Email Address, Phone Number, Password',
                                        ),
                                        _bullet('Login: Email and Password'),
                                        _bullet(
                                          'Profile: Profile Photo, National ID Number (New Zealand only)',
                                        ),
                                        _bullet(
                                          'Finance Section: Monthly income, fixed expenses (e.g., loans, EMIs), daily expenses',
                                        ),
                                        _paragraph(
                                          'We may also collect non-personal information like device type, OS version, and app usage statistics to improve performance.',
                                        ),

                                        SizedBox(height: 20),
                                        _sectionHeading(
                                          '2. How We Use Your Information',
                                        ),
                                        _bullet(
                                          'Create and manage your account',
                                        ),
                                        _bullet(
                                          'Display your financial summary and charts',
                                        ),
                                        _bullet('Provide customer support'),
                                        _bullet(
                                          'Improve our app features and user experience',
                                        ),
                                        _bullet(
                                          'Comply with legal obligations (e.g., identity verification for New Zealand users)',
                                        ),

                                        SizedBox(height: 20),
                                        _sectionHeading(
                                          '3. Data Sharing and Disclosure',
                                        ),
                                        _paragraph(
                                          'We do not sell your personal data to third parties. We may share data with:',
                                        ),
                                        _bullet(
                                          'Cloud service providers (e.g., Firebase) for authentication and data storage',
                                        ),
                                        _bullet(
                                          'Analytics services (e.g., Google Analytics for Firebase) for usage insights',
                                        ),
                                        _bullet(
                                          'Government authorities if legally required (e.g., identity verification)',
                                        ),

                                        SizedBox(height: 20),
                                        _sectionHeading('4. Data Security'),
                                        _paragraph(
                                          'We take reasonable steps to protect your data from unauthorized access, loss, or misuse. Your password is securely encrypted. Profile and ID uploads are stored securely.',
                                        ),

                                        SizedBox(height: 20),
                                        _sectionHeading('5. Your Rights'),
                                        _bullet(
                                          'View and update your personal information',
                                        ),
                                        _bullet(
                                          'Request deletion of your account and associated data',
                                        ),
                                        _bullet(
                                          'Contact us for any privacy concerns',
                                        ),

                                        SizedBox(height: 20),
                                        _sectionHeading(
                                          '6. Children’s Privacy',
                                        ),
                                        _paragraph(
                                          'Our app is not intended for children under 13 years of age. We do not knowingly collect personal information from children.',
                                        ),

                                        SizedBox(height: 20),
                                        _sectionHeading(
                                          '7. Changes to This Policy',
                                        ),
                                        _paragraph(
                                          'We may update this policy occasionally. When we do, we’ll notify you via in-app message or update the policy date above.',
                                        ),

                                        SizedBox(height: 20),
                                        _sectionHeading('8. Contact Us'),
                                        _paragraph(
                                          'If you have any questions about this policy, contact us at:\nEmail: tech@akegroup.co.nz\nAddress: 26c Chatsworth Road, Silverstream, Upper Hutt, 5019 , New Zealand',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }

  Widget _sectionHeading(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.secondaryFontFamily,
        color: Colors.black,
      ),
    );
  }

  Widget _paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontFamily: AppFonts.primaryFontFamily,
          color: Colors.black,
          height: 1.5,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _bullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.primaryFontFamily,
              color: Colors.black,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
