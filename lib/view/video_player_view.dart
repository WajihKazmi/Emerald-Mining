import 'package:emerald_mining/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:emerald_mining/view_model/video_runner_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart'; // Import for hiding bottom navigation

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hide the system bottom navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return WillPopScope(
      onWillPop: () async {
        // Prevent popping the screen unless the video is skippable
        return false; // Disable back button
      },
      child: Scaffold(
        backgroundColor:
            Colors.black, // Black background to match the video overlay
        appBar: AppBar(
          title: const Text('Watch Video'),
          backgroundColor:
              Colors.transparent, // Transparent to avoid blocking video
          elevation: 0, // No shadow for AppBar
          automaticallyImplyLeading: false, // Disable back button in AppBar
        ),
        body: Consumer<VideoRunnerProvider>(
          builder: (context, videoProvider, _) {
            return Stack(
              children: [
                // Video Player or loading indicator
                videoProvider.controller != null
                    ? YoutubePlayer(
                        controller: videoProvider.controller!,
                        showVideoProgressIndicator: true,
                      )
                    : const Center(child: CircularProgressIndicator()),
                
                // Skip Countdown or Skip Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: videoProvider.isSkippable
                        ? ElevatedButton(
                            onPressed: () {
                              // Skip the video and pop the screen
                              videoProvider.skipVideo(context,);
                              SystemChrome.setEnabledSystemUIMode(
                                  SystemUiMode.edgeToEdge);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Skip'),
                          )
                        : Text(
                            'Reward in ${videoProvider.timeLeft}s',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
