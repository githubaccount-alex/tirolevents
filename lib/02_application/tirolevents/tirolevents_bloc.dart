import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:tirolevents/02_application/tirolevents/tirolevents_event.dart';
import 'package:tirolevents/02_application/tirolevents/tirolevents_state.dart';

import '../../03_domain/entities/tirolevents_entity.dart';
import '../../03_domain/usecases/tirolevents_usecases.dart';
import '../../core/failures/failures.dart';

const GENERAL_FAILURE_MESSAGE =
    "Ups, etwas ist schiefgelaufen. Bitte versuche es erneut!";
const SERVER_FAILURE_MESSAGE = "Ups, API-Fehler. Bitte versuche es erneut!";

class TirolEventsBloc extends Bloc<TirolEventsEvent, TirolEventsState> {
  final TirolEventsUsecases usecases;
  int currentIndex = 0;
  List<TirolEventsEntity> currentEvents = [];

  TirolEventsBloc({required this.usecases}) : super(TirolEventsInitial()) {
    on<TirolEventsRequestEvent>((event, emit) async {
      emit(TirolEventsStateLoading());

      Either<Failure, List<TirolEventsEntity>> tiroleventsOrFailure =
          await usecases.getTirolEventUsecase(currentIndex);

      tiroleventsOrFailure.fold(
          (failure) => emit(
              TirolEventsStateError(message: _mapFailureToMessage(failure))),
          (tirolEvents) {
        currentEvents.addAll(tirolEvents);
        emit(TirolEventsStateLoaded(tirolEventsList: tirolEvents));
      });
    });

    on<TirolEventsLoadMoreEvent>((event, emit) async {
      currentIndex++;
      print(currentIndex);
      Either<Failure, List<TirolEventsEntity>> tiroleventsOrFailure =
          await usecases.getTirolEventUsecase(currentIndex);
      tiroleventsOrFailure.fold(
          (failure) => emit(
              TirolEventsStateError(message: _mapFailureToMessage(failure))),
          (tirolEvents) {
        currentEvents.addAll(tirolEvents);
        emit(TirolEventsStateLoaded(tirolEventsList: currentEvents));
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
}
