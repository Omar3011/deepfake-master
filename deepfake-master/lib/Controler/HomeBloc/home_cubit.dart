import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:deepfake/Service/Dio.dart';
import 'package:deepfake/model/DeepModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../Service/hive helper.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final ImagePicker _picker = ImagePicker();

  Future camera() async {
    emit(HomeLoading());
    final XFile? recordedFile = await _picker.pickVideo(
      source: ImageSource.camera,
    );
    if (recordedFile != null) {
      File video = File(recordedFile.path);
      emit(HomeNext(video));
    }
    emit(HomeError("no Select video"));
  }

  Future Gallery() async {
    emit(HomeLoading());
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File video = File(pickedFile.path);
      emit(HomeNext(video));
    }

    emit(HomeError("no Select video"));
  }

  getData() {
    emit(HomeLoading());
    try {
      List<DeepModel> data = [];
      data = HiveHelper.getData();
      print(data.length);
      EasyLoading.dismiss();
      emit(HomeDone(data));
    } catch (e) {
      print(e.toString());
      EasyLoading.dismiss();
      emit(HomeError(e.toString()));
    }
  }

  Update(DeepModel data, int index) async {
    emit(HomeLoading());
    EasyLoading.show(status: 'loading...');
    try {
      await HiveHelper.updateData(index, data);
      EasyLoading.dismiss();
      getData();
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Delete(int index) async {
    emit(HomeLoading());
    EasyLoading.show(status: 'loading...');
    try {
      await HiveHelper.deleteData(index);
      EasyLoading.dismiss();
      getData();
    } catch (e) {
      EasyLoading.dismiss();
      emit(HomeError(e.toString()));
    }
  }

  Download(String url) async {
    emit(HomeLoading());
    EasyLoading.show(status: 'loading...');
    try {
      File video = await DioService(dio: Dio()).downloadVideo(url);
      emit(HomeNext(video));
    } catch (e) {
      EasyLoading.dismiss();
      emit(HomeError("no Select video"));
    }
  }
}
