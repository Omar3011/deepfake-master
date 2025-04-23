part of 'result_cubit.dart';

@immutable
sealed class ResultState {}

final class ResultInitial extends ResultState {}

final class ResultLoading extends ResultState {}

final class ResultDone extends ResultState {
  String Result;
  ResultDone(this.Result);
}

final class ResultError extends ResultState {}
