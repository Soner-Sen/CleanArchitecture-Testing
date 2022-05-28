part of 'advicer_bloc.dart';

@immutable
abstract class AdvicerEvent {}

/// Event to get advice
class AdviceRequestedEvent extends AdvicerEvent {}
