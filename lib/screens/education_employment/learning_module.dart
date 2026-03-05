import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/controllers/education/learning_module_controller.dart';
import 'package:community_app/screens/education_employment/education_video_player.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:community_app/screens/widgets/dynamic_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningModule extends StatefulWidget {
  const LearningModule({super.key});

  @override
  State<LearningModule> createState() => _LearningModuleState();
}

class _LearningModuleState extends State<LearningModule> {
  final controller = Get.put(LearningModuleController());
  @override
  void initState() {
    super.initState();
    controller.fetchClass();
    controller.fetchSubject();
    controller.fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: CustomBottomNavigation(),
      body: SafeArea(
        child: Obx(() {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // * ─────────── App-bar ─────────── */
              MyAppBar(
                showMenuIcon: true,
                showBackIcon: true,
                screenName: 'Interactive Learning Modules',
                showBottom: false,
                userName: false,
                showNotificationIcon: true,
              ),

              const SizedBox(height: 30),

              // Row(
              //   children: [
              //     Expanded(
              //       child: SizedBox(
              //         height: 50,
              //         child: OutlinedButton(
              //           onPressed: () {
              //             showSearchableBottomSheet(
              //               context: context,
              //               api: 'education/get-all-subjects',
              //               name: controller.subjectName,
              //               id: controller.subjectId,
              //               sheetName: "Select Subject",
              //             );
              //           },
              //           style: OutlinedButton.styleFrom(
              //             backgroundColor: Colors.white,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(5),
              //             ),
              //             side: const BorderSide(color: Colors.white),
              //             padding: const EdgeInsets.symmetric(horizontal: 14),
              //           ),
              //           child: Obx(() {
              //             final selected = controller.subjectName.value;
              //             return Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Expanded(
              //                   child: Text(
              //                     selected.isNotEmpty
              //                         ? selected
              //                         : "Select Subject",
              //                     style: const TextStyle(
              //                       color: Colors.black87,
              //                       fontSize: 14,
              //                     ),
              //                     overflow: TextOverflow.ellipsis,
              //                   ),
              //                 ),
              //                 const Icon(Icons.arrow_drop_down, size: 22),
              //               ],
              //             );
              //           }),
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 20),
              //     Expanded(
              //       child: SizedBox(
              //         height: 50,
              //         child: OutlinedButton(
              //           onPressed: () {
              //             showSearchableBottomSheet(
              //               context: context,
              //               api: 'education/get-all-class',
              //               name: controller.className,
              //               id: controller.classId,
              //               sheetName: "Select Class",
              //             );
              //           },
              //           style: OutlinedButton.styleFrom(
              //             backgroundColor: Colors.white,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(5),
              //             ),
              //             side: const BorderSide(color: Colors.white),
              //             padding: const EdgeInsets.symmetric(horizontal: 14),
              //           ),
              //           child: Obx(() {
              //             final selected = controller.className.value;
              //             return Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Expanded(
              //                   child: Text(
              //                     selected.isNotEmpty
              //                         ? selected
              //                         : "Select Class",
              //                     style: const TextStyle(
              //                       color: Colors.black87,
              //                       fontSize: 14,
              //                     ),
              //                     overflow: TextOverflow.ellipsis,
              //                   ),
              //                 ),
              //                 const Icon(Icons.arrow_drop_down, size: 22),
              //               ],
              //             );
              //           }),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // --- Dropdowns Row ---
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.all(6),
              //         padding: const EdgeInsets.symmetric(horizontal: 12),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: DropdownButton<Map<String, dynamic>>(
              //           value: controller.selectedSubject.value,
              //           hint: const Text("Subject"),
              //           isExpanded: true,
              //           underline: const SizedBox(),
              //           items:
              //               controller.subjects.map((subject) {
              //                 return DropdownMenuItem<Map<String, dynamic>>(
              //                   value: subject,
              //                   child: Text(subject['name']),
              //                 );
              //               }).toList(),
              //           onChanged: (value) {
              //             controller.selectedSubject.value = value;
              //             controller.fetchVideos(
              //               subjectId: value?['id'],
              //               classId: controller.selectedClass.value?['id'],
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.all(6),
              //         padding: const EdgeInsets.symmetric(horizontal: 12),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: DropdownButton<Map<String, dynamic>>(
              //           value: controller.selectedClass.value,
              //           hint: const Text("Class"),
              //           isExpanded: true,
              //           underline: const SizedBox(),
              //           items:
              //               controller.classes.map((cls) {
              //                 return DropdownMenuItem<Map<String, dynamic>>(
              //                   value: cls,
              //                   child: Text(cls['name']),
              //                 );
              //               }).toList(),
              //           onChanged: (value) {
              //             controller.selectedClass.value = value;
              //             controller.fetchVideos(
              //               subjectId: controller.selectedSubject.value?['id'],
              //               classId: value?['id'],
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Subject Dropdown
                    Expanded(
                      child: GestureDetector(
                        onTap:
                            () => showSubjectBottomSheet(context, controller),
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => Text(
                                    controller.selectedSubject.value?['name'] ??
                                        "Select Subject",
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return GestureDetector(
                            onTap:
                                () => showClassBottomSheet(context, controller),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.selectedClass.value?['name'] ??
                                      "Select Class",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- Section Title ---
              Center(
                child: Text(
                  'Learn Anytime, in Your Language',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Access free, bite-sized learning videos and activities in English and Te Reo Māori.',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              // --- Horizontal Video List ---
              controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.videos.isEmpty
                  ? Center(
                    child: Column(
                      children: [
                        Icon(Icons.play_disabled_rounded, size: 35),
                        SizedBox(height: 10),
                        Text(
                          'No Videos Found.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                  : SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.videos.length,
                      itemBuilder: (context, index) {
                        final video = controller.videos[index];
                        final videoId = video['video_link'];
                        final thumbnailUrl =
                            "https://img.youtube.com/vi/$videoId/0.jpg";
                        if (controller.isLoading.value) {
                          return CircularProgressIndicator();
                        }
                        if (controller.videos.isEmpty) {
                          return Center(child: Text('No Videos Found.'));
                        }
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => EducationVideoPlayer(videoId: videoId),
                              arguments: {
                                'videoId': videoId,
                                'title': video['video_title'] ?? 'No Title',
                                'description':
                                    video['video_heading'] ?? 'No Description',
                              },
                            );
                          },
                          child: Container(
                            width: 240,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    thumbnailUrl,
                                    height: 130,
                                    width: 220,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 120,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  video['video_title'] ?? 'No Title',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  video['video_heading'] ?? 'No Description',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

              const SizedBox(height: 30),

              // --- Quick Learning Access Section ---
              Text(
                'Quick Learning Access',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              // Browse Playlists Card
              GestureDetector(
                onTap: () => Get.toNamed('/browsePlaylist'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/education/image (6).png',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: const Text(
                        'Browse Playlists',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: const Text(
                        'Explore curated video sets by subject and level.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 30),

              // // Saved Lessons Card
              // GestureDetector(
              //   onTap: () {},
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       ClipRRect(
              //         borderRadius: BorderRadius.circular(12),
              //         child: Image.network(
              //           'https://avatars.mds.yandex.net/i?id=aa906f240082121c0266c59351798b8dabcf1492-4252773-images-thumbs&n=13',
              //           height: 180,
              //           width: double.infinity,
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       const SizedBox(height: 10),
              //       const Text(
              //         'My Saved Lessons',
              //         style: TextStyle(
              //           fontSize: 15,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const Text(
              //         'Let users save/bookmark videos they like.',
              //         style: TextStyle(
              //           fontSize: 13,
              //           color: Colors.black87,
              //           height: 1.5,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          );
        }),
      ),
    );
  }
}

void showSubjectBottomSheet(
  BuildContext context,
  LearningModuleController controller,
) {
  final searchController = TextEditingController();
  RxList<Map<String, dynamic>> filteredSubjects = <Map<String, dynamic>>[].obs;

  filteredSubjects.assignAll(controller.subjects);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Column(
              children: [
                const Text(
                  "Select Subject",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Search field
                TextField(
                  controller: searchController,
                  onChanged: (query) {
                    if (query.isEmpty) {
                      filteredSubjects.assignAll(controller.subjects);
                    } else {
                      final filtered =
                          controller.subjects
                              .where(
                                (subj) => subj['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                              )
                              .toList();
                      filteredSubjects.assignAll(filtered);
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Type to search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // List of subjects
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: filteredSubjects.length,
                      itemBuilder: (context, index) {
                        final item = filteredSubjects[index];
                        return ListTile(
                          leading: const Icon(Icons.book_outlined),
                          title: Text(item['name'] ?? ''),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onTap: () {
                            controller.selectedSubject.value = item;

                            // Fetch playlist videos with subject + class
                            controller.fetchVideos(
                              subjectId: item['id'],
                              classId: controller.selectedClass.value?['id'],
                            );

                            Get.back();
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

void showClassBottomSheet(
  BuildContext context,
  LearningModuleController controller,
) {
  final searchController = TextEditingController();
  RxList<Map<String, dynamic>> filteredClasses = <Map<String, dynamic>>[].obs;

  // Initially load all classes
  filteredClasses.assignAll(controller.classes);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Column(
              children: [
                const Text(
                  "Select Class",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Search field
                TextField(
                  controller: searchController,
                  onChanged: (query) {
                    if (query.isEmpty) {
                      filteredClasses.assignAll(controller.classes);
                    } else {
                      final filtered =
                          controller.classes
                              .where(
                                (cls) => cls['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                              )
                              .toList();
                      filteredClasses.assignAll(filtered);
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Type to search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // List of classes
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      controller: scrollController,
                      itemCount: filteredClasses.length,
                      itemBuilder: (context, index) {
                        final item = filteredClasses[index];
                        return ListTile(
                          leading: const Icon(Icons.class_outlined),
                          title: Text(item['name'] ?? ''),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onTap: () {
                            controller.selectedClass.value = item;
                            controller.fetchVideos(
                              subjectId:
                                  controller.selectedSubject.value?['id'],
                              classId: item['id'],
                            );

                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
