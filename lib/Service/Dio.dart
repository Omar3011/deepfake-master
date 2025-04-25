// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class DioService {
  Dio dio;
  DioService({required this.dio});

  Future<File> downloadVideo(String url) async {
    try {
      // Get temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = "${tempDir.path}/downloaded_video.mp4";

      // Check if the file is already cached
      File cachedFile = await DefaultCacheManager().getSingleFile(url);
      if (cachedFile.existsSync()) {
        return cachedFile;
      }

      await dio.download(url, tempPath);
      return File(tempPath);
    } catch (e) {
      throw "Error downloading video: $e";
    }
  }

  Future uploadVideo(File video) async {
    try {
      String url =
          "https://0433-45-242-160-127.ngrok-free.app/api/v1/public/detect/video";
      FormData formData = FormData.fromMap({
        "video": await MultipartFile.fromFile(
          video.path,
          filename: "video.mp4",
        ),
      });

      Response response = await dio.post(
        url,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );
      print(response.statusCode);
      print("Upload response: ${response.data}");
      return response.data["result"];
    } catch (e) {
      print("Upload error: $e");
    }
  }

  Future postData(String linkApi, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        var response = await dio.post(
          linkApi,
          queryParameters: data,
          options: Options(headers: {"Content-Type": "application/json"}),
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.data);
          print(
            "=========================================$responseBody from dio package",
          );
          return responseBody;
        } else {
          return "Server Falure";
        }
      } else {
        return "Connection Falure";
      }
    } catch (e) {
      return e.toString();
    }
  }
}

checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].address.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}
