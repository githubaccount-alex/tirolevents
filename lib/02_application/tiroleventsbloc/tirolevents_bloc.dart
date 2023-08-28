import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import 'package:tirolevents/02_application/tiroleventsbloc/tirolevents_event.dart';
import 'package:tirolevents/02_application/tiroleventsbloc/tirolevents_state.dart';

import '../../03_domain/entities/tirolevents_entity.dart';
import '../../03_domain/services/tirolevents_service.dart';

import '../../core/failures/failures.dart';

const GENERAL_FAILURE_MESSAGE =
    "Ups, etwas ist schiefgelaufen. Bitte versuche es erneut!";
const SERVER_FAILURE_MESSAGE = "Ups, API-Fehler. Bitte versuche es erneut!";

class TirolEventsBloc extends Bloc<TirolEventsEvent, TirolEventsState> {
  final TirolEventsService service;
  StreamSubscription<Either<Failure, List<TirolEventsEntity>>>?
      _tirolEventsStreamSub;

  int currentIndex = 0;
  List<TirolEventsEntity> externalEvents = [];
  List<TirolEventsEntity> allEvents = [];

  TirolEventsBloc({required this.service}) : super(TirolEventsInitial()) {
    on<TirolEventsRequestEvent>((event, emit) async {
      emit(TirolEventsStateLoading());

      Either<Failure, List<TirolEventsEntity>> tiroleventsOrFailure =
          await service.getTirolEventService(currentIndex);

      tiroleventsOrFailure.fold(
          (failure) => emit(
              TirolEventsStateError(message: _mapFailureToMessage(failure))),
          (tirolEvents) {
        externalEvents.addAll(tirolEvents);
        add(ObserveOwnTirolEventEvent());
      });
    });

    on<TirolEventsLoadMoreEvent>((event, emit) async {
      currentIndex++;
      Either<Failure, List<TirolEventsEntity>> tiroleventsOrFailure =
          await service.getTirolEventService(currentIndex);
      tiroleventsOrFailure.fold(
          (failure) => emit(
              TirolEventsStateError(message: _mapFailureToMessage(failure))),
          (tirolEvents) {
        allEvents.addAll(tirolEvents);
        emit(TirolEventsStateLoaded(tirolEventsList: allEvents));
      });
    });

    on<ObserveOwnTirolEventEvent>((event, emit) async {
      emit(TirolEventsStateLoading());

      await _tirolEventsStreamSub?.cancel();
      _tirolEventsStreamSub = service
          .getTirolEventsFromFirebaseService()
          .listen((failureOrTirolEvents) => add(UpdateTirolEventsEvent(
              failureOrTirolEvents: failureOrTirolEvents)));
    });

    on<UpdateTirolEventsEvent>((event, emit) {
      event.failureOrTirolEvents.fold(
          (failures) => emit(
              TirolEventsStateError(message: _mapFailureToMessage(failures))),
          (tirolevents) {
        allEvents = [];
        allEvents.addAll(tirolevents);
        allEvents.addAll(externalEvents);


        emit(TirolEventsStateLoaded(tirolEventsList: allEvents));
      });
    });

    on<DeleteTirolEventEvent>((event, emit) async {
      emit(TirolEventsStateLoading());
      final failureOrSuccess = await service.deleteTirolEvent(event.tirolevent);
      failureOrSuccess.fold(
          (failure) =>
              TirolEventsStateError(message: _mapFailureToMessage(failure)),
          (r) {
        add(ObserveOwnTirolEventEvent());
        //emit(TirolEventsStateLoaded(tirolEventsList: currentEvents));
      });
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case GeneralFailure:
        return GENERAL_FAILURE_MESSAGE;
      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }

  @override
  Future<void> close() async {
    await _tirolEventsStreamSub?.cancel();
    return super.close();
  }
}
