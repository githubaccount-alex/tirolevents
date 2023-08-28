import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:tirolevents/01_presentation/tirolevents_overview_map/widgets/map.dart';

import '../../03_domain/entities/tirolevents_entity.dart';

@RoutePage()
class TirolEventsOverviewMapPage extends StatelessWidget {
  final List<TirolEventsEntity> tiroleventsList;

  const TirolEventsOverviewMapPage({super.key, required this.tiroleventsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("Events Overview"),
      ),
      body: OverviewMapBody(tirolEventsList: tiroleventsList),
    );
  }
}
