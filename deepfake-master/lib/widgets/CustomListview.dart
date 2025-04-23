import 'package:deepfake/model/DeepModel.dart';
import 'package:deepfake/widgets/CustomCard.dart';
import 'package:flutter/material.dart';

class CustomListview extends StatelessWidget {
  CustomListview({super.key, required this.data});
  List<DeepModel> data;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      //reverse: true,
      itemCount: data.length,
      itemBuilder:
          (context, index) => Customcard(info: data[index], index: index),
    );
  }
}
