import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tirolevents/03_domain/entities/id.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';
import 'package:tirolevents/03_domain/repositories/tirolevent_repository.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirolevents/04_infrastructure/extensions/firebase_helpers.dart';
import '../../03_domain/entities/random_tirol_coordinates.dart';
import '../../core/exceptions/exceptions.dart';
import '../../core/failures/failures.dart';
import '../datasources/tirolevents_remote_datasource.dart';
import '../models/tirolevents_firebase_model.dart';
import '../models/tirolevents_model.dart';

class TirolEventsRepositoryImpl implements TirolEventsRepository {
  final TirolEventsRemoteDatasource tirolEventsRemoteDatasource;
  final FirebaseFirestore firebaseFirestore;

  TirolEventsRepositoryImpl(
      {required this.tirolEventsRemoteDatasource,
      required this.firebaseFirestore});

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
          id: UniqueID.fromUniqueString(""),
          title: title,
          imageURL: imageUrl,
          date: date,
          description: description,
          hyperlink: hyperlink,
          isOwnEvent: false,
          coordinate: RandomTirolCoordinate(),
          key: UniqueKey());

      listTirolEvents.add(tirolEvent);
      print("---");
    }

    return listTirolEvents;
  }

  @override
  Stream<Either<Failure, List<TirolEventsEntity>>>
      getTirolEventsFromFirebase() async* {
    final userDoc = await firebaseFirestore.userDocument();

    yield* userDoc.tirolEventCollection
        .snapshots()
        .map((snapshot) => right<Failure, List<TirolEventsEntity>>(snapshot.docs
            .map(
                (doc) => TirolEventsFirebaseModel.fromFirestore(doc).toDomain())
            .toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains('PERMISSION_DENIED')) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }

  @override
  Future<Either<Failure, Unit>> createTirolEvent(
      TirolEventsEntity tirolEventsEntity) async {
    try {
      final userDoc = await firebaseFirestore.userDocument();
      final tirolEventModel =
          TirolEventsFirebaseModel.fromDomain(tirolEventsEntity);

      await userDoc.tirolEventCollection
          .doc(tirolEventModel.id)
          .set(tirolEventModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSION_DENIED")) {
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTirolEvent(
      TirolEventsEntity tirolEventsEntity) async {
    try {
      final userDoc = await firebaseFirestore.userDocument();
      final tirolEventModel =
          TirolEventsFirebaseModel.fromDomain(tirolEventsEntity);

      await userDoc.tirolEventCollection
          .doc(tirolEventModel.id)
          .update(tirolEventModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSION_DENIED")) {
        // NOT_FOUND
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTirolEvent(
      TirolEventsEntity tirolEventsEntity) async {
    try {
      final userDoc = await firebaseFirestore.userDocument();
      final tirolEventModel =
          TirolEventsFirebaseModel.fromDomain(tirolEventsEntity);

      await userDoc.tirolEventCollection.doc(tirolEventModel.id).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSION_DENIED")) {
        // NOT_FOUND
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }
}
