

import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

abstract class TirolEventsFormEvent {}

class InitializeTirolEventsDetailPage extends TirolEventsFormEvent {
  final TirolEventsEntity? tirolevent;
  InitializeTirolEventsDetailPage({required this.tirolevent});
}

class SafePressedEvent extends TirolEventsFormEvent {
  final String? title;
  final String? imageURL;
  final String? date;
  final String? description;
  final String? hyperlink;

  SafePressedEvent({required this.title, required this.description, required this.date, required this.hyperlink, required this.imageURL});
}

