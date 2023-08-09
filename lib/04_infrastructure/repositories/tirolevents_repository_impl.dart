import 'package:dartz/dartz.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';
import 'package:tirolevents/03_domain/repositories/tirolevent_repository.dart';
import 'package:html_unescape/html_unescape.dart';
import '../../core/exceptions/exceptions.dart';
import '../../core/failures/failures.dart';
import '../datasources/tirolevents_remote_datasource.dart';
import '../models/tirolevents_model.dart';

class TirolEventsRepositoryImpl implements TirolEventsRepository {
  final TirolEventsRemoteDatasource tirolEventsRemoteDatasource;

  TirolEventsRepositoryImpl({required this.tirolEventsRemoteDatasource});

  @override
  Future<Either<Failure, List<TirolEventsEntity>>> getTirolEventsFromApi(
      int index) async {
    try {
      final remoteTirolEvents =
          await tirolEventsRemoteDatasource.getTirolEventsAsModelFromApi(index);

      final remoteTirolEventsList = fromModelToList(remoteTirolEvents);

      return Right(remoteTirolEventsList);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }

  List<TirolEventsEntity> fromModelToList(TirolEventModel inputModel) {
    List<TirolEventsEntity> listTirolEvents = [];
    String model = inputModel.eventListRaw;
    var unescape = HtmlUnescape();
    String decodedString = unescape.convert(model);
    List<String> events = decodedString.split('''img src="''');

    for (int i = 1; i < events.length; i++) {
      String event = events[i];

      String title = event.split('''title="''')[1].split('''" width="''')[0];
      print(title);

      String imageUrl = event.split('''" alt="''')[0];

      String date =
          event.split('''\n                        ''')[1].split('''\n''')[0];

      String description = event
          .split('''\n                </p><p>''')[1].split('''</p><span''')[0];
      print(description);

      String hyperlink = event.split('''class="h2"><a href="''')[1].split(
          '''" class="hasLink"''')[0];
      print(hyperlink);

      TirolEventsEntity tirolEvent = TirolEventsEntity(
          title: title,
          imageUrl: imageUrl,
          date: date,
          description: description,
          hyperlink: hyperlink);

      listTirolEvents.add(tirolEvent);
      print("---");
    }

    return listTirolEvents;
  }
}
