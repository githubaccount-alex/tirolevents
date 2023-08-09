import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

abstract class TirolEventsState {}

class TirolEventsInitial extends TirolEventsState {}

class TirolEventsStateLoading extends TirolEventsState {}

class TirolEventsStateLoaded extends TirolEventsState {
  final List<TirolEventsEntity> tirolEventsList;

  TirolEventsStateLoaded({required this.tirolEventsList});
}

class TirolEventsStateError extends TirolEventsState {
  final String message;

  TirolEventsStateError({required this.message});
}
