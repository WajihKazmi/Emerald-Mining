import 'package:emerald_mining/view/video_player_view.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart'; // Import PodPlayer
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:emerald_mining/view_model/earn_coins_view_model.dart';

class VideoRunnerProvider with ChangeNotifier {
  PodPlayerController? _controller;
  Timer? _timer;
  int _timeLeft = 0;
  bool _isSkippable = false;
  bool isPlayingVideo = false;

  PodPlayerController? get controller => _controller;
  bool get isSkippable => _isSkippable;
  int get timeLeft => _timeLeft;
  String videoId = '';

  void startVideo(BuildContext context, String videoUrl, String videoId,
      int durationInSeconds) {
    this.videoId = videoId;

    if (_controller != null) {
      _controller!.dispose(); // Dispose existing controller if any
    }

    _controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        videoUrl,
      ),
    )..initialise();
    

    isPlayingVideo = true;
    _timeLeft = durationInSeconds;
    _isSkippable = false;
    notifyListeners();

    _startTimer(context);

    // Automatically redirect to the VideoPlayerScreen
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const VideoPlayerScreen(),
    ));
  }

  void _startTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        _isSkippable = true;
        _timer?.cancel();
        notifyListeners();
      }
    });
  }

  void _endVideo(BuildContext context) async {
    if (isPlayingVideo) {
      isPlayingVideo = false;
      _controller?.dispose();
      _timer?.cancel();

      await Provider.of<EarnCoinsViewModel>(context, listen: false)
          .watchedVideo(context, videoId);

      final userProvider = Provider.of<UserViewModel>(context, listen: false);
      final user = userProvider.user;
      await userProvider.userApi(context, user.id);

      Navigator.of(context).pop(); // Pop the video screen
    }
    notifyListeners();
  }

  void skipVideo(BuildContext context) async {
    _endVideo(context);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }
}

// import 'package:emerald_mining/view/video_player_view.dart';
// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'dart:async';
// import 'package:provider/provider.dart';
// import 'package:emerald_mining/view_model/earn_coins_view_model.dart';

// class VideoRunnerProvider with ChangeNotifier {
//   YoutubePlayerController? _controller;
//   Timer? _timer;
//   int _timeLeft = 0;
//   bool _isSkippable = false;
//   bool isPlayingVideo = false;

//   YoutubePlayerController? get controller => _controller;
//   bool get isSkippable => _isSkippable;
//   int get timeLeft => _timeLeft;
//   String videoId = '';
//   void startVideo(BuildContext context, String videoUrl, String videoId,
//       int durationInSeconds) {
//     this.videoId = videoId;
//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );

//     // Add a listener to detect when the video ends and trigger watchedVideo
//     _controller!.addListener(() {
//       if (_controller!.value.playerState == PlayerState.ended) {
//         _endVideo(
//           context,
//         ); // Trigger watchedVideo when the video ends
//       }
//     });

//     isPlayingVideo = true;
//     _timeLeft = durationInSeconds;
//     _isSkippable = false;
//     notifyListeners();

//     _startTimer(context);

//     // Automatically redirect to the VideoPlayerScreen
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => const VideoPlayerScreen(),
//     ));
//   }

//   void _startTimer(BuildContext context) {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_timeLeft > 0) {
//         _timeLeft--;
//         notifyListeners();
//       } else {
//         _isSkippable = true;
//         _timer?.cancel();
//         notifyListeners();
//       }
//     });
//   }

//   // Method to handle video ending or skipping and trigger watchedVideo
//   void _endVideo(BuildContext context) async {
//     if (isPlayingVideo) {
//       isPlayingVideo = false;
//       // Call the watchedVideo function from EarnCoinsViewModel when video ends
//       await Provider.of<EarnCoinsViewModel>(context, listen: false)
//           .watchedVideo(context, videoId);
//       Navigator.of(context).pop(); // Pop the video screen
//     }
//     notifyListeners();
//   }

//   // Method to manually skip the video and trigger watchedVideo
//   void skipVideo(
//     BuildContext context,
//   ) async {
//     _endVideo(context); // Trigger watchedVideo when skipped
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }
// }
