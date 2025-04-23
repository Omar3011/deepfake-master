import 'dart:io';

import 'package:deepfake/view/VideoScreen.dart';
import 'package:deepfake/constant/color.dart';
import 'package:deepfake/widgets/CustomButton.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Controler/HomeBloc/home_cubit.dart';
import 'custom_text_form_filed.dart';

class FloatButton extends StatelessWidget {
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  TextEditingController edit = TextEditingController();

  FloatButton({super.key, this.fabKey});

  final fabKey;
  final ImagePicker _picker = ImagePicker();
  XFile? _videoFile;

  // Pick video from Gallery
  Future<File?> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File video = File(pickedFile.path);
      return video;
      print(video.path);
    }
    return null;
  }

  // Record video using Camera
  Future<File?> _recordVideo() async {
    final XFile? recordedFile = await _picker.pickVideo(
      source: ImageSource.camera,
    );
    if (recordedFile != null) {
      File video = File(recordedFile.path);
      return video;
      print(video.path);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is HomeNext) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Videoscreen(videofile: state.video),
            ),
          );
        }
      },
      child: FabCircularMenuPlus(
        fabOpenIcon: Icon(Icons.add),
        animationCurve: Curves.easeInOutCirc,
        alignment: Alignment.bottomRight,
        ringColor: Colors.blue.withAlpha(25),
        ringDiameter: 340.0,
        ringWidth: 90.0,
        fabColor: ColorConst.base,
        fabSize: 55.0,
        fabElevation: 8.0,
        fabIconBorder: CircleBorder(),
        key: fabKey,
        children: <Widget>[
          Custombutton(
            color: Colors.orange,
            onpress: () async {
              {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Download Video"),
                      content: Form(
                        key: form_key,
                        child: SizedBox(
                          height: 80,
                          width: 176,
                          child: CustomTextFormFiled(
                            maxLength: 1000,
                            hintText: 'Enter Url',
                            controller: edit,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Field is Required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      actions: [
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              print("Done");
                              if (form_key.currentState!.validate()) {
                                print("Done");
                                await BlocProvider.of<HomeCubit>(
                                  context,
                                ).Download(edit.text);
                                Navigator.pop(context);
                              }

                              // Close dialog
                            },
                            child: Text(
                              "Download",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            icon: Icons.download_for_offline,
          ),
          Custombutton(
            color: Color.fromRGBO(74, 40, 168, 1.0),
            onpress: () async {
              await BlocProvider.of<HomeCubit>(context).Gallery();
            },
            icon: Icons.photo_library_sharp,
          ),
          Custombutton(
            color: Colors.deepOrange,
            onpress: () async {
              await BlocProvider.of<HomeCubit>(context).camera();
            },
            icon: Icons.camera_alt,
          ),
        ],
      ),
    );
  }
}
