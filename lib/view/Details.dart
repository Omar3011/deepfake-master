import 'package:flutter/material.dart';

import '../widgets/DetailsVideo.dart';

class Details extends StatelessWidget {
  const Details({
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Detailsvideo(video: video, name: name, result: result, data: data),
    );
  }
}
