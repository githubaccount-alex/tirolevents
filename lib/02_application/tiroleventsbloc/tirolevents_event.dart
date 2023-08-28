import 'package:dartz/dartz.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

import '../../core/failures/failures.dart';

abstract class TirolEventsEvent {}

// event when button is pressed
class TirolEventsRequestEvent extends TirolEventsEvent {}

class TirolEventsLoadMoreEvent extends TirolEventsEvent {}

class ObserveOwnTirolEventEvent extends TirolEventsEvent {

}

class UpdateTirolEventsEvent extends TirolEventsEvent {

  final Either<Failure, List<TirolEventsEntity>> failureOrTirolEvents;
  UpdateTirolEventsEvent({required this.failureOrTirolEvents});
}

class DeleteTirolEventEvent extends TirolEventsEvent {
  final TirolEventsEntity tirolevent;
  DeleteTirolEventEvent({required this.tirolevent});
}

