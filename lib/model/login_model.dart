//import 'package:deep_faking_detection/core/database/api/end_points.dart';

class LoginModel {
  // final String message;
  final String idToken;

  LoginModel({
    //required this.message,
    required this.idToken,
  });
  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
      //message: jsonData[Apikeys.message],
      idToken: jsonData["Apikeys.idToken"],
    );
  }
}
