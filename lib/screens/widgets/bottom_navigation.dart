import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your navigation items
    final List<Map<String, String>> navItems = [
      {'icon': 'assets/images/Message.png', 'route': '/coming_soon'},
      {'icon': 'assets/images/home.png', 'route': '/home'},
      {'icon': 'assets/images/scan.png', 'route': '/scan'},
      {'icon': 'assets/images/Cakender.png', 'route': '/coming_soon'},
      {'icon': 'assets/images/Help.png', 'route': '/coming_soon'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: const Border(top: BorderSide(color: Colors.white)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            spreadRadius: 3,
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
        children:
            navItems.map((item) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(item['route'] ?? '/home');
                },
                child: SizedBox(
                  height: 56,
                  width: 56,
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center, // Keep alignment at center
                      children: [
                        // Conditionally display the circle
                        if (item['icon'] == 'assets/images/scan.png')
                          Positioned(
                            top: -30,
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE1DDFF),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white, // Your border color
                                  width: 3,
                                ),
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Color.fromRGBO(0, 0, 0, 0.1),
                                //     spreadRadius: 0,
                                //     blurRadius: 6,
                                //     offset: Offset(0, -6),
                                //   ),
                                // ],
                              ),
                            ),
                          ),

                        // Image is always displayed, but its size may change
                        // Icon image: move up only if scan
                        if (item['icon'] == 'assets/images/scan.png')
                          Positioned(
                            top: -15,
                            child: Image.asset(
                              item['icon'] ?? 'assets/images/scan.png',
                              color: const Color(0xFF000000),
                              width: 32,
                              height: 32,
                            ),
                          )
                        else
                          Image.asset(
                            item['icon'] ?? 'assets/images/scan.png',
                            color: const Color(0xFF000000),
                            width: 24,
                            height: 24,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
