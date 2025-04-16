part of 'harry_cubit.dart';

sealed class HarryState{}

final class HarryInitial extends HarryState {}

final class Success extends HarryState {
  final List<Model> models;

  Success(this.models);
}

final class Loading extends HarryState{}

final class Error extends HarryState{
  final String message;

  Error(this.message);
}