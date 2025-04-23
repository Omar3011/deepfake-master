import 'package:deepfake/model/DeepModel.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  static String note = "Note";
  static late Box<DeepModel> mybox;
  static Future<void> intil() async {
    mybox = await Hive.openBox<DeepModel>(note);
  }

  static Future<void> addData(DeepModel value) async {
    try {
      await mybox.add(value);
      print("Data Added Successfully: ${value.name}");
    } catch (e) {
      print("Error Adding Data: $e");
    }
  }

  static Future<void> deleteData(int index) async {
    await mybox.deleteAt(index);
  }

  static List<DeepModel> getData() {
    return mybox.values.toList();
  }

  static Future<void> updateData(int index, DeepModel updateNote) async {
    await mybox.putAt(index, updateNote);
  }
}
