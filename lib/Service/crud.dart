// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:deepfake/Service/Dio.dart';
import 'package:deepfake/constant/statusrequest.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

String _basicAuth = 'Basic ${base64Encode(utf8.encode("dddd:sdfsdfsdfdsf"))}';
Map<String, String> _myheaders = {"authorization": _basicAuth};

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkApi, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkApi),
          body: data,
          headers: _myheaders,
        );
        print(
          "===================================================${response.statusCode}\n" +
              "===================================================${response.body}\n" +
              "===================================================${linkApi} ",
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          print(responseBody);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      print(e);
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> addRequestWithImageOne(
    url,
    data,
    File? image, [
    String? namerequest,
  ]) async {
    if (namerequest == null) {
      namerequest = "file";
    }

    var uri = Uri.parse(url);
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll(_myheaders);

    if (image != null) {
      var length = await image.length();
      var stream = http.ByteStream(image.openRead());
      stream.cast();
      var multipartFile = http.MultipartFile(
        namerequest,
        stream,
        length,
        filename: basename(image.path),
      );
      request.files.add(multipartFile);
    }

    // add Data to request
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    // add Data to request
    // Send Request
    var myrequest = await request.send();
    // For get Response Body
    var response = await http.Response.fromStream(myrequest);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }
}
