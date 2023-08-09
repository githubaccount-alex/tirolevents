import 'package:dartz/dartz.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';
import 'package:tirolevents/03_domain/repositories/tirolevent_repository.dart';

import '../../core/failures/failures.dart';

class TirolEventsUsecases {
  final TirolEventsRepository tirolEventRepository;

  TirolEventsUsecases({required this.tirolEventRepository});

  Future<Either<Failure, List<TirolEventsEntity>>> getTirolEventUsecase(
      int index) async {
    return tirolEventRepository.getTirolEventsFromApi(index);

    // Businesslogik hier implementieren !
  }
}
