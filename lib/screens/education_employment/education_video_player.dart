import 'package:community_app/app_settings/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EducationVideoPlayer extends StatefulWidget {
  final String videoId;
  const EducationVideoPlayer({super.key, required this.videoId});

  @override
  State<EducationVideoPlayer> createState() => _EducationVideoPlayerState();
}

class _EducationVideoPlayerState extends State<EducationVideoPlayer> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(247, 0, 0, 0),
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  padding: EdgeInsets.only(left: 10.0),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color.fromARGB(247, 0, 0, 0),
            actions: [
              Padding(
                padding: EdgeInsetsGeometry.only(right: 10.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.whiteTextField,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark_outline,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(child: Center(child: player)),
        );
      },
    );
  }
}
