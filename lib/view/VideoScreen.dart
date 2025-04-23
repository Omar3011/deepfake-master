import 'dart:io';

import 'package:deepfake/Controler/ResultBloc/result_cubit.dart';
import 'package:deepfake/model/DeepModel.dart';
import 'package:deepfake/widgets/DetailsVideo.dart';
import 'package:deepfake/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../widgets/text_widget.dart';

class Videoscreen extends StatefulWidget {
  Videoscreen({super.key, required this.videofile});
  File? videofile;
  @override
  State<Videoscreen> createState() => _VideoscreenState();
}

class _VideoscreenState extends State<Videoscreen> {
  late VideoPlayerController controller;
  bool isPlay = false;
  late ResultCubit result;
  String name = '';
  @override
  void initState() {
    super.initState();
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    name = "deep$timestamp";
    result = ResultCubit();
    result.send(widget.videofile);
    controller = VideoPlayerController.file(widget.videofile!)
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<ResultCubit, ResultState>(
        bloc: result,
        builder: (context, state) {
          if (state is ResultLoading) {
            return Center(child: Text(""));
          }
          if (state is ResultDone) {
            print(state.Result);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Detailsvideo(
                    video: widget.videofile,
                    name: name,
                    result: state.Result,
                    data: DateFormat.yMMMEd().format(DateTime.now()),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      DeepModel data = DeepModel(
                        video_path: widget.videofile!.path,
                        name: name,
                        result: state.Result,
                        date: DateTime.now(),
                      );
                      await result.add(data);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    icon: Icon(Icons.done_outline, color: Colors.white),
                    label: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: TextWidget(
                text: "check your Internet",
                size: 18,
                color: Colors.black,
              ),
            );
          }
        },
      ),
    );
  }
}
