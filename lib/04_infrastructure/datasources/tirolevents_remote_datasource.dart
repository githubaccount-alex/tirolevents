import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tirolevents/04_infrastructure/models/tirolevents_model.dart';
import 'package:tirolevents/core/exceptions/exceptions.dart';

abstract class TirolEventsRemoteDatasource {
  Future<TirolEventModel> getTirolEventsAsModelFromApi(int index);
}

class TirolEventsRemoteDatasourceImpl implements TirolEventsRemoteDatasource {
  final http.Client client;

  TirolEventsRemoteDatasourceImpl({required this.client});

  @override
  Future<TirolEventModel> getTirolEventsAsModelFromApi(int index) async {
    String requestIndex = "";

    if (index > 0) {
      requestIndex = "/${index}";
    }

    final response = await client.get(
      Uri.parse(
          'https://www.tirol.at/reisefuehrer/veranstaltungen/events$requestIndex?outputType=json'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);

      return TirolEventModel.fromJsonToModel(responseBody);
    }
  }
}
