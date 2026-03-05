import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/controllers/qr_code_controller.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final controller = Get.put(QrCodeController());
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
                screenName: 'My Scans & history',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),
              SizedBox(height: 30),
              SizedBox(
                // height: 50,
                child: Obx(() {
                  return Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.isEWallet.value = true;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color:
                                  controller.isEWallet.value
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "E-Wallet",
                              style: TextStyle(
                                color:
                                    controller.isEWallet.value
                                        ? Colors.white
                                        : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(width: 10),
                        // Community Badge Button
                        GestureDetector(
                          onTap: () {
                            controller.isEWallet.value = false;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color:
                                  !controller.isEWallet.value
                                      ? AppColors.primaryColor
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Community Badge",
                              style: TextStyle(
                                color:
                                    !controller.isEWallet.value
                                        ? Colors.white
                                        : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              Obx(() {
                return controller.isEWallet.value
                    ? EWalletScreen()
                    : CommunityBadgeScreen();
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class EWalletScreen extends StatelessWidget {
  final QrCodeController controller = Get.find();

  EWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
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
              child: Image.network(
                'https://writestylesonline.com/wp-content/uploads/2021/02/Michele-Round-Circle-2020.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Jack Warner",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("ID: 09556887706", style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteTextField,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$${controller.corporateBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Corporate Balance",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteTextField,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$${controller.personalBalance.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
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
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.whiteTextField,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Balance", style: TextStyle(fontSize: 14)),
                  Text(
                    "\$${(controller.corporateBalance + controller.personalBalance).toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => Text(
                "Time Remaining: ${_formatTime(controller.timer.value)}",
              ),
            ),
            SizedBox(height: 16),
            Obx(
              () => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: QrImageView(data: controller.qrData.value, size: 200),
              ),
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed('/transactionHistory');
              },
              icon: Icon(Icons.timelapse_sharp, color: AppColors.primaryColor),
              label: Text(
                "See Transactions",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }
}

class CommunityBadgeScreen extends StatelessWidget {
  final QrCodeController controller = Get.find();

  CommunityBadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
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
            child: Image.network(
              'https://writestylesonline.com/wp-content/uploads/2021/02/Michele-Round-Circle-2020.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Jack Warner",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text("ID: 09556887706", style: TextStyle(fontSize: 16)),
          SizedBox(height: 16),
          Container(
            width: 250,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteTextField,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.group, size: 24, color: AppColors.primaryColor),
                SizedBox(width: 8),
                Text("Community 1 | 618-011", style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Obx(() {
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: controller.progress.value),
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, animatedProgress, child) {
                return CustomPaint(
                  painter: RectBorderProgress(
                    progress: animatedProgress,
                    strokeWidth: 3,
                    progressColor: AppColors.primaryColor,
                    baseColor: Color.fromARGB(198, 255, 233, 254),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QrImageView(
                      data: controller.qrData.value,
                      size: 200,
                    ),
                  ),
                );
              },
            );
          }),
          SizedBox(height: 16),
          Text("Thu 01, May 2025", style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text(
            "This QR code is used for facilities access only",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class RectBorderProgress extends CustomPainter {
  final double progress; // 0 → 1
  final Color progressColor;
  final Color baseColor;
  final double strokeWidth;
  final double borderRadius;

  RectBorderProgress({
    required this.progress,
    required this.progressColor,
    required this.baseColor,
    this.strokeWidth = 1,
    this.borderRadius = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Base border
    final basePaint =
        Paint()
          ..color = baseColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;
    canvas.drawRRect(rrect, basePaint);

    // Progress border
    final progressPaint =
        Paint()
          ..color = progressColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    // Path for full rounded rect
    final borderPath = Path()..addRRect(rrect);

    // Compute total perimeter
    final metrics = borderPath.computeMetrics().first;
    final drawLength = metrics.length * progress;

    // Extract partial path
    final extractPath = metrics.extractPath(0, drawLength);

    canvas.drawPath(extractPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant RectBorderProgress oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.baseColor != baseColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}
