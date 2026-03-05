import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/app_settings/settings.dart';
import 'package:community_app/controllers/education/learning_module_controller.dart';
import 'package:community_app/screens/education_employment/your_playlist.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowsePlaylist extends StatefulWidget {
  const BrowsePlaylist({super.key});

  @override
  State<BrowsePlaylist> createState() => _BrowsePlaylistState();
}

class _BrowsePlaylistState extends State<BrowsePlaylist> {
  final controller = Get.put(LearningModuleController());
  @override
  void initState() {
    super.initState();
    controller.fetchClass();
    controller.fetchSubject();
    controller.fetchPlaylistVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: AppColors.screenBg,
      bottomNavigationBar: CustomBottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              children: [
                // * ─────────── App-bar ─────────── */
                MyAppBar(
                  showMenuIcon: true,
                  showBackIcon: true,
                  screenName: 'Browse Playlists',
                  showBottom: true,
                  userName: false,
                  showNotificationIcon: true,
                ),
                SizedBox(height: 10),
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
                                      controller
                                              .selectedSubject
                                              .value?['name'] ??
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
                                  () =>
                                      showClassBottomSheet(context, controller),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GetBuilder<LearningModuleController>(
                    builder: (ctrl) {
                      if (controller.isLoading.value) {
                        return CircularProgressIndicator();
                      }
                      if (controller.playlistVideos.isEmpty) {
                        return Center(child: Text('No Playlist Found'));
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.playlistVideos.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.65,
                            ),
                        itemBuilder: (context, index) {
                          final video = controller.playlistVideos[index];
                          final thumbnail =
                              '${AppSettings.baseUrl}${video.thumbnailImage}';
                          final title = video.thumbnailDescription;

                          return GestureDetector(
                            onTap: () {
                              Get.to(() => YourPlaylist(video: video));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Thumbnail with Play Icon
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      thumbnail,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (_, _, _) => const Icon(
                                            Icons.image_not_supported,
                                          ),
                                    ),
                                  ),

                                  /// Text Info
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily:
                                                AppFonts.secondaryFontFamily,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),

                                        _buildMetaText(
                                          'Videos:',
                                          video.videos.length.toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildMetaText(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(top: 2),
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: TextStyle(
              fontSize: 11,
              fontFamily: AppFonts.secondaryFontFamily,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 11,
              fontFamily: AppFonts.secondaryFontFamily,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    ),
  );
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
                  child: Obx(
                    () => ListView.builder(
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
                            controller.fetchPlaylistVideos(
                              subjectId: item['id'],
                              classId: controller.selectedClass.value?['id'],
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
                            controller.fetchPlaylistVideos(
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
