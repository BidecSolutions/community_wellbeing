import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:community_app/controllers/video_controller.dart';
import 'package:community_app/screens/widgets/videos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    final cultureController = Get.put(VideoController());
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
      items:
          cultureController.videoIds.asMap().entries.map((entry) {
            final index = entry.key;
            final videoId = entry.value;
            // final thumbnail = cultureController.thumbnails[index]['image'];
            return GestureDetector(
              onTap: () {
                Get.to(
                  Videos(videoId: videoId),
                  arguments: {'videoId': videoId},
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://img.youtube.com/vi/$videoId/hqdefault.jpg",
                    fit: BoxFit.cover,
                    width: 400,
                    height: 100,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
