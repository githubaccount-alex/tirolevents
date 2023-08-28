import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tirolevents/03_domain/entities/id.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

import '../../03_domain/entities/random_tirol_coordinates.dart';

class TirolEventsFirebaseModel {
  final String id;
  final String title;
  final String imageUrl;
  final String date;
  final String description;
  final String hyperlink;
  final dynamic serverTimeStamp;

  TirolEventsFirebaseModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.date,
      required this.description,
      required this.hyperlink,
      required this.serverTimeStamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'date': date,
      'description': description,
      'hyperlink': hyperlink,
      'serverTimeStamp': serverTimeStamp
    };
  }

  factory TirolEventsFirebaseModel.fromMap(Map<String, dynamic> map) {
    return TirolEventsFirebaseModel(
        id: "",
        title: map['title'] as String,
        imageUrl: map['imageUrl'] as String,
        date: map['date'] as String,
        description: map['description'] as String,
        hyperlink: map['hyperlink'] as String,
        serverTimeStamp: map['serverTimeStamp']);
  }

  TirolEventsFirebaseModel copyWith(
      {String? id,
      String? title,
      String? imageUrl,
      String? date,
      String? description,
      String? hyperlink,
      dynamic serverTimeStamp}) {
    return TirolEventsFirebaseModel(
        id: id ?? this.id,
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        date: date ?? this.date,
        description: description ?? this.description,
        hyperlink: hyperlink ?? this.hyperlink,
        serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp);
  }

  factory TirolEventsFirebaseModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return TirolEventsFirebaseModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  TirolEventsEntity toDomain() {
    return TirolEventsEntity(
        id: UniqueID.fromUniqueString(id),
        title: title,
        imageURL: imageUrl,
        date: date,
        description: description,
        hyperlink: hyperlink,
        isOwnEvent: true,
    coordinate: RandomTirolCoordinate(),
    key: UniqueKey());
  }

  factory TirolEventsFirebaseModel.fromDomain(
      TirolEventsEntity tirolEventsEntity) {
    return TirolEventsFirebaseModel(
        id: tirolEventsEntity.id.value,
        title: tirolEventsEntity.title,
        imageUrl: tirolEventsEntity.imageURL,
        date: tirolEventsEntity.date,
        description: tirolEventsEntity.description,
        hyperlink: tirolEventsEntity.hyperlink,
        serverTimeStamp: FieldValue.serverTimestamp());
  }
}
