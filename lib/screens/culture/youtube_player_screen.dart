import 'package:community_app/app_settings/fonts.dart';
import 'package:community_app/models/language_corner.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final String videoId;
  final VideoModel video;
  const YouTubePlayerScreen({
    super.key,
    required this.videoId,
    required this.video,
  });

  @override
  State<YouTubePlayerScreen> createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;
  late VideoItemModel? selectedVideo;
  @override
  void initState() {
    super.initState();
    // Find the selected video based on videoId
    selectedVideo = widget.video.videos.firstWhere(
      (v) => YoutubePlayer.convertUrlToId(v.videoLink) == widget.videoId,
      orElse: () => widget.video.videos.first, // fallback
    );
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          // backgroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(247, 0, 0, 0),
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  padding: EdgeInsets.only(left: 9.0),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop(); // or Get.back();
                  },
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            // backgroundColor: Colors.black,
            backgroundColor: const Color.fromARGB(247, 0, 0, 0),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      selectedVideo?.videoHeading ?? 'No title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.secondaryFontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  player,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
