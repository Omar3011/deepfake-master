import 'package:hive_flutter/hive_flutter.dart';
part 'DeepModel.g.dart';

@HiveType(typeId: 0)
class DeepModel {
  @HiveField(0)
  String video_path;
  @HiveField(1)
  String name;
  @HiveField(2)
  String result;
  @HiveField(3)
  DateTime date;
  DeepModel({
    required this.video_path,
    required this.name,
    required this.result,
    required this.date,
  });
}
