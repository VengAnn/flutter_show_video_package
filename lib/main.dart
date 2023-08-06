import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: VideoScreen(),
    );
  }
}

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ChewieController? _chewieController; // Declare as nullable

  @override
  void initState() {
    super.initState();
    setupVideoPlayer();
  }

  Future<void> setupVideoPlayer() async {
    String videoUrl = "assets/videos/song.mp4"; // Path to the video in assets

    VideoPlayerController videoPlayerController =
        VideoPlayerController.asset(videoUrl);
    await videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
      );
    });
  }

  @override
  void dispose() {
    _chewieController?.dispose(); // Dispose if not null
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: 200,
            color: Colors.red,
            child: _chewieController != null
                ? Chewie(controller: _chewieController!)
                : CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
