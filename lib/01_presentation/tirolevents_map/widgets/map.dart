import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../03_domain/entities/tirolevents_entity.dart';

class MapBody extends StatelessWidget {
  final TirolEventsEntity tirolEventsEntity;

  const MapBody({Key? key, required this.tirolEventsEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mapController = MapController();
    double _currentZoom = 13.0;
    LatLng _currentCenter = LatLng(tirolEventsEntity.coordinate.latitude,
        tirolEventsEntity.coordinate.longitude);
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: _currentCenter,
            zoom: _currentZoom,
          ),
          children: <Widget>[
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 70,
                  height: 70,
                  point: LatLng(tirolEventsEntity.coordinate.latitude,
                      tirolEventsEntity.coordinate.longitude),
                  builder: (ctx) => Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child: const Icon(Icons.accessibility, color: Colors.white, size: 50,),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
            bottom: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    _currentZoom = _currentZoom + 1;
                    _mapController.move(_currentCenter, _currentZoom);
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    _currentZoom = _currentZoom - 1;
                    _mapController.move(_currentCenter, _currentZoom);
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ))
      ],
    );
  }
}
