part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerState {}

class AdvicerInitial extends AdvicerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AdvicerLoading extends AdvicerState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class AdvicerLoaded extends AdvicerState with EquatableMixin {
  final String advice;
  AdvicerLoaded({required this.advice});
  @override
  List<Object?> get props => [advice];
}

class AdvicerError extends AdvicerState with EquatableMixin {
  final String error;
  AdvicerError({required this.error});
  @override
  List<Object?> get props => [error];
}
