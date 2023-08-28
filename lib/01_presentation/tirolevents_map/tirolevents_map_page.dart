import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:tirolevents/01_presentation/tirolevents_map/widgets/info_field.dart';
import 'package:tirolevents/01_presentation/tirolevents_map/widgets/map.dart';

import '../../03_domain/entities/tirolevents_entity.dart';

@RoutePage()
class TirolEventsMapPage extends StatelessWidget {
  final TirolEventsEntity tirolEventsEntity;

  const TirolEventsMapPage({Key? key, required this.tirolEventsEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("Location on Map"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double availableHeight = constraints.maxHeight;

          double mapBodyHeight = availableHeight * 0.6;
          double mapInfoFieldHeight = availableHeight * 0.4;

          return Column(
            children: [
              Container(
                height: mapBodyHeight,
                child: MapBody(tirolEventsEntity: tirolEventsEntity),
              ),
              Container(
                height: mapInfoFieldHeight,
                child: MapInfoField(tirolEventsEntity: tirolEventsEntity),
              ),
            ],
          );
        },
      ),
    );
  }
}
