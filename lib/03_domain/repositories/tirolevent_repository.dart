import 'package:dartz/dartz.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

import '../../core/failures/failures.dart';

abstract class TirolEventsRepository {
  Future<Either<Failure, List<TirolEventsEntity>>> getTirolEventsFromApi(
      int index);
}
