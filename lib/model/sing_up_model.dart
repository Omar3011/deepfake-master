class SignUpModel {
  final String status;
  final String message;

  SignUpModel({
    required this.status,
    required this.message,
  });
  factory SignUpModel.fromJson(Map jsonData) {
    return SignUpModel(
      status: jsonData['status'],
      message: jsonData['message'],
    );
  }
}
