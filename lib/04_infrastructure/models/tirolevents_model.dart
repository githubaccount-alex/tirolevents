class TirolEventModel {
  final String eventListRaw;

  TirolEventModel({required this.eventListRaw});

  factory TirolEventModel.fromJsonToModel(Map<String, dynamic> json) {
    return TirolEventModel(
      eventListRaw: json["list"],
    );
  }
}
