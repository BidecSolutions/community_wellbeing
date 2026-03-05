import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your navigation items without scan
    final List<Map<String, String>> navItems = [
      {
        'icon': 'assets/images/privacy_nav.png',
        'route': '/privacy_policy',
      },
      {
        'icon': 'assets/images/home.png',
        'route': '/home',
      },
      {
        'icon': 'assets/images/logoutnav.png',
        'route': '/login',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: const Border(top: BorderSide(color: Colors.white)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: 40,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems.map((item) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(item['route'] ?? '/home');
            },
            child: SizedBox(
              height: 56,
              width: 56,
              child: Center(
                child: Image.asset(
                  item['icon'] ?? 'assets/images/home.png',
                  color: const Color(0xFF000000),
                  width: 34,
                  height: 34,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
