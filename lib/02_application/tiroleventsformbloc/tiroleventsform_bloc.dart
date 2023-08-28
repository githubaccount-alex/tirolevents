

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:tirolevents/02_application/tiroleventsformbloc/tiroleventsform_event.dart';
import 'package:tirolevents/02_application/tiroleventsformbloc/tiroleventsform_state.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

import '../../03_domain/repositories/tirolevent_repository.dart';
import '../../core/failures/failures.dart';

class TirolEventsFormBloc extends Bloc<TirolEventsFormEvent, TirolEventsFormState> {

  final TirolEventsRepository tirolEventsRepository;

  TirolEventsFormBloc({required this.tirolEventsRepository}) : super(TirolEventsFormState.initial()) {
    on<InitializeTirolEventsDetailPage>((event, emit) {
      if (event.tirolevent != null) {
        emit(state.copyWith(tirolEventsEntity: event.tirolevent, isEditing: true));
      } else {
        emit(state);
      }
    });

    on<SafePressedEvent>((event, emit) async {
      Either<Failure, Unit>? failureOrSuccess;

      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.title != null && event.description != null && event.date != null && event.imageURL != null && event.hyperlink != null) {
        final TirolEventsEntity editedTirolEvent = state.tirolEventsEntity.copyWith(title: event.title, description: event.description, date: event.date, imageUrl: event.imageURL, hyperlink: event.hyperlink);

        if (state.isEditing) {
          failureOrSuccess = await tirolEventsRepository.updateTirolEvent(editedTirolEvent);
        } else {
          failureOrSuccess = await tirolEventsRepository.createTirolEvent(editedTirolEvent);
        }
      }

      emit(state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          failureOrSuccessOption: optionOf(failureOrSuccess)));
    });



  }


}