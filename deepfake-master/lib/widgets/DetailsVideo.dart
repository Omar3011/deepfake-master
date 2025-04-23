import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constant/color.dart';
import 'text_widget.dart';

class Detailsvideo extends StatefulWidget {
  const Detailsvideo({
    super.key,
    required this.video,
    required this.name,
    required this.result,
    required this.data,
  });
  final video;
  final name;
  final result;
  final data;
  @override
  State<Detailsvideo> createState() => _DetailsvideoState();
}

class _DetailsvideoState extends State<Detailsvideo> {
  late VideoPlayerController controller;
  bool isPlay = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.file(widget.video!)
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorConst.base,
            ),
            child: Center(
              child: TextWidget(
                text: "Video Screen",
                size: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(8),
            height: (MediaQuery.sizeOf(context).height * 0.6) + 1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorConst.second.withOpacity(0.3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child:
                          controller.value.isInitialized
                              ? SizedBox(
                                width:
                                    MediaQuery.sizeOf(
                                      context,
                                    ).width, // Full screen width
                                child: SizedBox(
                                  width: controller.value.size.width * 0.3,
                                  height: controller.value.size.height * 0.4,
                                  child: VideoPlayer(controller),
                                ),
                              )
                              : const Center(
                                child: CircularProgressIndicator(),
                              ),
                    ),
                    const SizedBox(
                      height: 16,
                    ), // Space between video and button
                    ElevatedButton.icon(
                      onPressed: () {
                        if (!isPlay) {
                          controller.play();
                        } else {
                          controller.pause();
                        }
                        setState(() {
                          isPlay = !isPlay;
                        });
                      },
                      icon: Icon(isPlay ? Icons.pause : Icons.play_arrow),
                      label: Text(isPlay ? "Pause" : "Play"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                widget.result == 'real'
                    ? TextWidget(
                      text: widget.result.toString().toUpperCase(),
                      size: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    )
                    : TextWidget(
                      text: widget.result.toString().toUpperCase(),
                      size: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                TextWidget(text: widget.data, size: 20, color: Colors.grey),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
