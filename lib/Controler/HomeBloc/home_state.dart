part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeDone extends HomeState {
  List<DeepModel> data;
  HomeDone(this.data);
}

final class HomeNext extends HomeState {
  File video;
  HomeNext(this.video);
}

final class HomeError extends HomeState {
  String error;
  HomeError(this.error);
}
