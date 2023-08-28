


import 'package:dartz/dartz.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

import '../../core/failures/failures.dart';

class TirolEventsFormState {
  final TirolEventsEntity tirolEventsEntity;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<Failure, Unit>> failureOrSuccessOption;

  TirolEventsFormState(
      {required this.tirolEventsEntity,
        required this.showErrorMessages,
        required this.isEditing,
        required this.isSaving,
        required this.failureOrSuccessOption});

  factory TirolEventsFormState.initial() => TirolEventsFormState(
      tirolEventsEntity: TirolEventsEntity.empty(),
      showErrorMessages: false,
      isEditing: false,
      isSaving: false,
      failureOrSuccessOption: none());

  TirolEventsFormState copyWith({
    TirolEventsEntity? tirolEventsEntity,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<Failure, Unit>>? failureOrSuccessOption,
  }) {
    return TirolEventsFormState(
      tirolEventsEntity: tirolEventsEntity ?? this.tirolEventsEntity,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
      failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}