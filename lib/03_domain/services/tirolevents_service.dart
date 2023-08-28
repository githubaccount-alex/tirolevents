import 'package:dartz/dartz.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';
import 'package:tirolevents/03_domain/repositories/tirolevent_repository.dart';

import '../../core/failures/failures.dart';

// Business logic !
class TirolEventsService {
  final TirolEventsRepository tirolEventRepository;

  TirolEventsService({required this.tirolEventRepository});

  Future<Either<Failure, List<TirolEventsEntity>>> getTirolEventService(
      int index) async {
    return tirolEventRepository.getTirolEventsFromApi(index);
  }

  Stream<Either<Failure, List<TirolEventsEntity>>>
      getTirolEventsFromFirebaseService() {
    return tirolEventRepository.getTirolEventsFromFirebase();
  }

  Future<Either<Failure, Unit>> createTirolEventService(
      TirolEventsEntity tirolEventsEntity) {
    return tirolEventRepository.createTirolEvent(tirolEventsEntity);
  }

  Future<Either<Failure, Unit>> updateTirolEventService(
      TirolEventsEntity tirolEventsEntity) {
    return tirolEventRepository.updateTirolEvent(tirolEventsEntity);
  }

  Future<Either<Failure, Unit>> deleteTirolEvent(
      TirolEventsEntity tirolEventsEntity) {
    return tirolEventRepository.deleteTirolEvent(tirolEventsEntity);
  }
}
