import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../app_settings/colors.dart';
import '../../app_settings/settings.dart';
import '../../database/connection.dart';
import 'package:cached_network_image/cached_network_image.dart';

final box = GetStorage();

String getLastName(String fullName) {
  List<String> parts = fullName.trim().split(RegExp(r'\s+'));
  return parts.isNotEmpty ? parts.last : '';
}

final loginUser = "${box.read('name') ?? 'Guest'}";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context); // close drawer
    Get.toNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = box.read('image') ?? '';
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.99, 0.0),
                end: Alignment(0.01, 0.0),
                colors: [
                  AppColors.loginGradientStart,
                  AppColors.loginGradientEnd,
                ],
              ),
            ),
            child: Stack(
              children: <Widget>[
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: imagePath != null && imagePath != ''
                          ? CachedNetworkImage(
                        imageUrl: '${AppSettings.baseUrl}${box.read('image')}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/user_av.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Image.asset(
                        'assets/images/user_av.jpg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Kia Ora,',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppFonts.secondaryFontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            box.read('name') ?? 'Guest',
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: AppFonts.secondaryFontFamily,
                              fontWeight: FontWeight.bold,
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
          ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                'assets/images/your_profile.png',
                color: Colors.black,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text(
              'Your Profile',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () => _navigate(context, '/your_profile'),
          ),

          ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                'assets/images/house.cat.png',
                color: Colors.black,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () => _navigate(context, '/home'),
          ),
          ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                'assets/images/finance.png',
                color: Colors.black,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text(
              'Finance',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () => _navigate(context, '/finance'),
          ),
          ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                'assets/images/house.cat.png',
                color: Colors.black,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text(
              'Housing & Infrastructure',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () => _navigate(context, '/housing'),
          ),
          ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                'assets/images/social.cat.png',
                color: Colors.black,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text(
              'Parenting & Family',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () => _navigate(context, '/parenting'),
          ),
          ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                'assets/images/health.cat.png',
                color: Colors.black,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text(
              'Health & Wellbeing',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () => _navigate(context, '/health'),
          ),
          ListTile(
            leading: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                'assets/images/social.cat.png',
                color: Colors.black,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text(
              'My Orders',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () => _navigate(context, '/orderScreen'),
          ),

          ListTile(
            leading: SizedBox(
              width: 23,
              height: 23,
              child: Image.asset(
                'assets/images/privacy_policy.png',
                color: Colors.black,
                colorBlendMode: BlendMode.modulate,
                fit: BoxFit.contain,
              ),
            ),
            title: const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () => _navigate(context, '/privacy_policy'),
          ),

          const Divider(), // Separates logout visually

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontFamily: AppFonts.primaryFontFamily,
              ),
            ),
            onTap: () {
              logoutUser(token: box.read('token'));
            },
          ),
//-- functionality not develop for --//

          // ListTile(
          //   leading: const Icon(Icons.logout, color: Colors.black),
          //   title: const Text(
          //     'Chat Room',
          //     style: TextStyle(
          //       fontSize: 16,
          //       fontFamily: AppFonts.primaryFontFamily,
          //     ),
          //   ),
          //   onTap: () {
          //     box.erase();
          //     Get.offAllNamed('/chatting');
          //   },
          // ),
        ],
      ),
    );
  }
}

Future<void> logoutUser({required String token}) async {
  final url = Uri.parse('${AppSettings.baseUrl}auth/remove-token');
  await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  final dbInstance = UserTokenDatabase();
  final db = await dbInstance.database;
  await db.delete('user_tokens');
  await db.delete('login_check');
  box.erase();
  Get.offAllNamed('/login');
}
