import 'dart:io';

import 'package:deepfake/Controler/HomeBloc/home_cubit.dart';
import 'package:deepfake/model/DeepModel.dart';
import 'package:deepfake/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../constant/color.dart';
import '../view/Details.dart';
import '../view/home.dart';
import 'custom_text_form_filed.dart';

class Customcard extends StatefulWidget {
  Customcard({super.key, required this.info, required this.index});
  DeepModel info;
  int index;

  @override
  State<Customcard> createState() => _CustomcardState();
}

class _CustomcardState extends State<Customcard> {
  TextEditingController edit = TextEditingController();
  bool IsEdit = false;
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    edit.text = widget.info.name;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => Details(
                  video: File(widget.info.video_path),
                  name: widget.info.name,
                  result: widget.info.result,
                  data: DateFormat.yMMMEd().format(widget.info.date),
                ),
          ),
        );
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height * 100 / 776,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        //padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: ColorConst.second.withOpacity(0.4),
        ),

        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              child: Image.asset(
                "assets/images/img_1.png",
                height: MediaQuery.sizeOf(context).height * 100 / 776,
                width: MediaQuery.sizeOf(context).width * 100 / 360,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !IsEdit
                      ? TextWidget(
                        text:
                            widget.info.name.length > 15
                                ? "${widget.info.name.substring(0, 15)}..."
                                : widget.info.name,
                        size: 17,
                        fontWeight: FontWeight.bold,
                      )
                      : Form(
                        key: form_key,
                        child: SizedBox(
                          height: 51,
                          width: 176,
                          child: CustomTextFormFiled(
                            hintText: 'Enter data',
                            controller: edit,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Field is Required";
                              } else {
                                return null;
                              }
                            },
                            maxLength: 12,
                          ),
                        ),
                      ),
                  widget.info.result == 'real'
                      ? TextWidget(
                        text: widget.info.result,
                        size: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      )
                      : TextWidget(
                        text: widget.info.result,
                        size: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                  TextWidget(
                    text: DateFormat.yMMMEd().format(widget.info.date),
                    size: 16,
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                    if (IsEdit) {
                      if (form_key.currentState!.validate()) {
                        await BlocProvider.of<HomeCubit>(context).Update(
                          DeepModel(
                            video_path: widget.info.video_path,
                            name: edit.text,
                            result: widget.info.result,
                            date: widget.info.date,
                          ),
                          widget.index,
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false,
                        );
                      }
                    }
                    setState(() {
                      IsEdit = !IsEdit;
                    });
                  },
                  icon: !IsEdit ? Icon(Icons.edit) : Icon(Icons.done),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Confirmation"),
                          content: Text(
                            "Are you sure you want to delete this item?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context), // Cancel
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await BlocProvider.of<HomeCubit>(
                                  context,
                                ).Delete(widget.index);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                  (route) => false,
                                ); // Close dialog
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
