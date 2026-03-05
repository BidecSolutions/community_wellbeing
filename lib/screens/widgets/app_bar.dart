import 'package:community_app/app_settings/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class MyAppBar extends StatelessWidget {
  final bool showNotificationIcon;
  final bool showMenuIcon;
  final bool showBackIcon;
  final Widget? bottom;
  final bool showBottom;
  final bool userName;
  final String screenName;
  const MyAppBar({
    super.key,
    this.showNotificationIcon = false,
    this.showMenuIcon = false,
    this.showBackIcon = false,
    this.bottom,
    this.userName = true,
    this.showBottom = true,
    this.screenName = "",
  });
  @override
  Widget build(BuildContext context) {
    final loginUser = "kia Ora,\n${box.read('name') ?? 'Guest'}";
    final parts = loginUser.split('\n');
    final greeting = parts.length > 1 ? '${parts.first}\n' : '';
    final name = parts.length > 1 ? parts.last : parts.first;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row (back, title, icons)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBackIcon)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

              if (userName)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: greeting,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  AppFonts.secondaryFontFamily, // Use your font
                            ),
                          ),
                          TextSpan(
                            text: name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily:
                                  AppFonts.secondaryFontFamily, // Use your font
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(width: 48), // placeholder for alignment
              Row(
                children: [
                  if (showNotificationIcon)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ), // Add right padding
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  if (showMenuIcon)
                    Builder(
                      builder:
                          (context) => Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 20.0,
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                            ),
                          ),
                    ),
                ],
              ),
            ],
          ),

          if (screenName != "")
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  screenName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.secondaryFontFamily,
                  ),
                ),
              ),
            ),
          if (showBottom)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
