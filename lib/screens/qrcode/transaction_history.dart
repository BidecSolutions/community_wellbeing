import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/controllers/qr_code_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final controller = Get.put(QrCodeController());
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
                /* ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Transaction history',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Color(0xfffd5ebff), Color(0xfffF5F5F0)],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Jack Warner",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("ID: 09556887706", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              // horizontal: 20,
                              vertical: 10,
                            ),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "\$750.00",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteTextField,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Corporate Balance",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteTextField,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.whiteTextField,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "\$750.00",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Personal Balance",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFilterButton('All'),
                        _buildFilterButton('Credit'),
                        _buildFilterButton('Debit'),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  var data = controller.filteredTransactions;

                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10);
                    },
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var data = controller.filteredTransactions;

                      // ensure expandedStates length matches data length
                      if (controller.expandedStates.length != data.length) {
                        controller.expandedStates.value = List.generate(
                          data.length,
                          (index) => false,
                        );
                      }
                      var cashDetail = data[index];
                      return CustomExpansionTile(tx: cashDetail, index: index);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildFilterButton(String filterName) {
  final QrCodeController controller = Get.find();
  bool isSelected = controller.selectedFilter.value == filterName;
  return ElevatedButton(
    onPressed: () {
      controller.changeFilter(filterName);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
      foregroundColor: isSelected ? Colors.white : Colors.black,
      elevation: 0,
    ),
    child: Text(filterName),
  );
}

class CustomExpansionTile extends StatelessWidget {
  final TransactionModel tx;
  final int index;

  CustomExpansionTile({super.key, required this.tx, required this.index});

  final QrCodeController controller = Get.find<QrCodeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isExpanded = controller.expandedStates[index];

      return ExpansionTile(
        // hide default arrow
        trailing: const SizedBox.shrink(),

        // control expansion state
        initiallyExpanded: isExpanded,
        onExpansionChanged: (value) {
          controller.toggleExpansion(index, value);
        },

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: AppColors.whiteTextField,
        collapsedBackgroundColor: AppColors.whiteTextField,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDE7F6),
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // optional rounded corners
                  ),
                  child: Image.network(
                    'https://thumbs.dreamstime.com/b/dinner-icon-trendy-dinner-logo-concept-white-background-dinner-icon-trendy-dinner-logo-concept-white-background-131149368.jpg?w=768',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Text(
                      "Community 1",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.primaryFontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 45),
                    Text(
                      "\$${tx.amount}",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.primaryFontFamily,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bill # 250ABC989-67UY5',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
                ),
                Text(
                  'June 19th, 2025',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: AppFonts.primaryFontFamily,
                  ),
                ),
              ],
            ),

            // Custom bottom center "Details + Icon"
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.primaryFontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: isExpanded ? 0.5 : 0.0,
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ],
        ),

        children: [ListTile(title: Text("Details: ${tx.details}"))],
      );
    });
  }
}
