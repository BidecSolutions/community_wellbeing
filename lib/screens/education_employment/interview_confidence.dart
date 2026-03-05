import 'package:community_app/app_settings/colors.dart';
import 'package:community_app/controllers/education/interview_confidence_controller.dart';
import 'package:community_app/screens/education_employment/education_video_player.dart';
import 'package:community_app/screens/widgets/app_bar.dart';
import 'package:community_app/screens/widgets/bottom_navigation.dart';
import 'package:community_app/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InterviewConfidence extends StatefulWidget {
  const InterviewConfidence({super.key});

  @override
  State<InterviewConfidence> createState() => _InterviewConfidenceState();
}

class _InterviewConfidenceState extends State<InterviewConfidence> {
  final controller = Get.put(InterviewConfidenceController());
  @override
  void initState() {
    super.initState();
    controller.fetchClass();
    controller.fetchVideos();
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
                  screenName: 'Ace Your Interview with Confidence',
                  showBottom: false,
                  userName: false,
                  showNotificationIcon: true,
                ),

                SizedBox(height: 10),
                Text(
                  'Watch real-life examples, learn expert tips, and practice with ease — everything you need to feel job-ready.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap:
                              () =>
                                  showCategoryBottomSheet(context, controller),
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
                            child: Obx(() {
                              return Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Color(0xFF908E8E),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      controller
                                              .selectedCategory
                                              .value?['category_name'] ??
                                          "Select Category",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.isLoading.value) {
                    return CircularProgressIndicator();
                  }
                  if (controller.videos.isEmpty) {
                    return Center(child: Text('No Videos Found.'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.videos.length,
                    itemBuilder: (context, index) {
                      final video = controller.videos[index];
                      final videoId = video['video_link'];

                      // YouTube thumbnail URL
                      final thumbnailUrl =
                          "https://img.youtube.com/vi/$videoId/0.jpg";

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
                          width: 240, // give width so text can fit
                          margin: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  thumbnailUrl,
                                  height: 180,
                                  width: double.infinity,
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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

void showCategoryBottomSheet(
  BuildContext context,
  InterviewConfidenceController controller,
) {
  final searchController = TextEditingController();
  RxList<Map<String, dynamic>> filteredCategories =
      <Map<String, dynamic>>[].obs;

  filteredCategories.assignAll(controller.category);

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
                  "Select Category",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Search field
                TextField(
                  controller: searchController,
                  onChanged: (query) {
                    if (query.isEmpty) {
                      filteredCategories.assignAll(controller.category);
                    } else {
                      final filtered =
                          controller.category
                              .where(
                                (cat) => cat['category_name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                              )
                              .toList();
                      filteredCategories.assignAll(filtered);
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

                // List of categories
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      controller: scrollController,
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final item = filteredCategories[index];
                        return ListTile(
                          leading: const Icon(Icons.category_outlined),
                          title: Text(item['category_name'] ?? ''),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onTap: () {
                            controller.selectedCategory.value = item;
                            controller.fetchVideos(videoId: item['id']);
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
