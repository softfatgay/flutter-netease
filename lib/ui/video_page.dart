import 'package:flutter/material.dart';
import 'package:flutter_app/constant/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final Map? params;

  const VideoPage({Key? key, this.params}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('url-------${widget.params!['url']}');

    _controller = VideoPlayerController.network('${widget.params!['url']}');

    _controller!.addListener(() {
      setState(() {});
    });
    _controller!.setLooping(false);
    _controller!.initialize().then((_) => setState(() {
          _controller!.play();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              child: Icon(
                Icons.arrow_back_ios,
                color: backWhite,
              ),
              top: MediaQuery.of(context).padding.top + 20,
              left: 16,
            ),
            Center(
              child: Container(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_controller!),
                      _ControlsOverlay(controller: _controller),
                      VideoProgressIndicator(_controller!,
                          allowScrubbing: true),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, this.controller}) : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller!.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Container(
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      child: Image.asset(
                        'assets/images/video_play.png',
                        height: 28,
                        width: 28,
                      ),
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller!.value.isPlaying
                ? controller!.pause()
                : controller!.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller!.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller!.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    height: 30,
                    value: speed,
                    child: Text('$speed x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('倍速${controller!.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
