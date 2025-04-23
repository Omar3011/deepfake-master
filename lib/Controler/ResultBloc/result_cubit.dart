import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:deepfake/Service/Dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';

import '../../Service/hive helper.dart';
import '../../model/DeepModel.dart';

part 'result_state.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(ResultInitial());
  Future send(File? Video) async {
    try {
      emit(ResultLoading());
      EasyLoading.show(status: 'loading...');
      var response = await DioService(dio: Dio()).uploadVideo(Video!);
      EasyLoading.dismiss();
      emit(ResultDone(response));
    } catch (e) {
      EasyLoading.dismiss();
      emit(ResultError());
    }
  }

  add(DeepModel data) async {
    emit(ResultLoading());
    EasyLoading.show(status: 'loading...');
    try {
      await HiveHelper.addData(data);
      List<DeepModel> d = [];
      d = HiveHelper.getData();
      EasyLoading.dismiss();
      print(d.length);
    } catch (e) {
      EasyLoading.dismiss();
      emit(ResultError());
    }
  }
}
