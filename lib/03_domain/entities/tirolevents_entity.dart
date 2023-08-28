import 'package:flutter/material.dart';
import 'package:tirolevents/03_domain/entities/random_tirol_coordinates.dart';

import 'id.dart';

class TirolEventsEntity {
  final UniqueID id;
  final String title;
  final String imageURL;
  final String date;
  final String description;
  final String hyperlink;
  final bool isOwnEvent;
  final RandomTirolCoordinate coordinate;
  final Key key;

  TirolEventsEntity(
      {required this.id,
      required this.title,
      required this.imageURL,
      required this.date,
      required this.description,
      required this.hyperlink,
      required this.isOwnEvent,
      required this.coordinate,
      required this.key});

  factory TirolEventsEntity.empty() {
    return TirolEventsEntity(
        id: UniqueID(),
        title: "",
        description: "",
        date: "",
        hyperlink: "",
        imageURL: "",
        isOwnEvent: false,
        coordinate: RandomTirolCoordinate(),
      key: UniqueKey()
        );
  }

  TirolEventsEntity copyWith({
    UniqueID? id,
    String? title,
    String? imageUrl,
    String? date,
    String? description,
    String? hyperlink,
    bool? isOwnEvent,
    RandomTirolCoordinate? coordinate,
    Key? key
  }) {
    return TirolEventsEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      imageURL: imageUrl ?? this.imageURL,
      date: date ?? this.date,
      description: description ?? this.description,
      hyperlink: hyperlink ?? this.hyperlink,
      isOwnEvent: isOwnEvent ?? this.isOwnEvent,
      coordinate: coordinate ?? this.coordinate,
      key: key ?? this.key
    );
  }
}
