import 'package:flutter/material.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/colors.dart';
import 'package:get/get.dart';
import '../../controllers/apply_for_help/someone_know_controller.dart';
import '../widgets/drawer.dart';

class SomeoneKnow extends StatelessWidget {
  SomeoneKnow({super.key});
  final controller = Get.put(SomeoneKnowController());
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
                showMenuIcon: false,
                showBackIcon: true,
                screenName: 'Let Someone Know \nYou’re Okay',
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

              /* ─────────── App-bar End ─────────── */
              // --- Emergency Help & Clinic Access Start--
              const SizedBox(height: 20),
              //--- Heading Start --
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment:
                      Alignment
                          .centerLeft, // Ensures left alignment inside any parent
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How Are You Feeling Today?',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.primaryFontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //--- Heading End --

              //---  feeling start --
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(
                  () => Column(
                    children: [
                      buildRadioCard(
                        controller,
                        option: 'I’m Okay Today',
                        color: Colors.green,
                      ),
                      const SizedBox(height: 12),
                      buildRadioCard(
                        controller,
                        option: 'Feeling Unwell / low energy',
                        color: Colors.yellow,
                      ),
                      const SizedBox(height: 12),
                      buildRadioCard(
                        controller,
                        option: 'Need someone to check in ',
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),

              //--- feeling end --

              // --- share your location start --
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Share Your Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Obx(
                      () => Switch(
                        value: controller.toggleValue.value,
                        onChanged: (value) {
                          controller.toggleValue.value = value;
                        },
                        activeColor: Colors.green, // ✅ Green when ON
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.white,
                        activeTrackColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // --- share your location end --
              //--- who to notify start ---
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Choose Who To Notify',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: controller.selectedRelation.value,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedRelation.value = newValue;
                            }
                          },
                          items:
                              controller.relations.map<
                                DropdownMenuItem<String>
                              >((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                          underline:
                              const SizedBox(), // Removes default underline
                          dropdownColor:
                              Colors.white, // Dropdown menu background
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //--- who to notify end ---

              //--- description box start --
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Anything You’d Like To Add?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => TextField(
                        controller: controller.descriptionController,
                        maxLines: 5,
                        minLines: 3,
                        decoration: InputDecoration(
                          hintText: 'eg:Just checking in — had a rough night.',
                          hintStyle: const TextStyle(fontSize: 14),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          errorText:
                              controller.descriptionError.value.isEmpty
                                  ? null
                                  : controller.descriptionError.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //---description box end ---
              SizedBox(height: 20),

              Center(
                child: SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // radio button widget
  Widget buildRadioCard(
    SomeoneKnowController controller, {
    required String option,
    required Color color,
  }) {
    final isSelected = controller.selectedOption.value == option;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => controller.selectOption(option),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.hintColor,
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child:
                    isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
