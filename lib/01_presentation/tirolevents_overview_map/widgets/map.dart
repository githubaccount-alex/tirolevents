import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OverviewMapBody extends StatelessWidget {
  final List<TirolEventsEntity> tirolEventsList;

  const OverviewMapBody({super.key, required this.tirolEventsList});

  List<Marker> _entityListToMarkerList(
      List<TirolEventsEntity> tirolEventsList) {
    List<Marker> markerList = <Marker>[];
    for (TirolEventsEntity entity in tirolEventsList) {
      Marker marker = Marker(
        key: entity.key,
        point: LatLng(entity.coordinate.latitude, entity.coordinate.longitude),
        builder: (ctx) => Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.redAccent,
          ),
          child: const Icon(Icons.accessibility, color: Colors.white),
        ),
      );
      markerList.add(marker);
    }
    return markerList;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final containerWidth = size.width * 0.95;
    final ScrollController _scrollController = ScrollController();
    final MapController _mapController = MapController();
    final List<Marker> _markerList = _entityListToMarkerList(tirolEventsList);
    double _currentZoom = 7.0;
    LatLng _currentCenter = _markerList[0].point;
    int _selectedMarkerIndex = -1;

    return Center(
      child: Stack(children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
              interactiveFlags: InteractiveFlag.pinchZoom |
                  InteractiveFlag.drag |
                  InteractiveFlag.doubleTapZoom,
              center: _currentCenter,
              maxZoom: 17,
              minZoom: 4,
              zoom: _currentZoom,
              onPositionChanged: (MapPosition mapPosition, bool hasGesture) {
                _currentCenter = mapPosition.center!;
                _currentZoom = mapPosition.zoom!;
              }),
          children: <Widget>[
            TileLayer(
              retinaMode: true,
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                centerMarkerOnClick: false,
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                maxClusterRadius: 45,
                size: const Size(40, 40),
                anchor: AnchorPos.align(AnchorAlign.center),
                fitBoundsOptions: const FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                  maxZoom: 15,
                ),
                markers: _markerList,
                onMarkerTap: (Marker marker) {
                  double _markerlong = marker.point.longitude;
                  double _markerlat = marker.point.latitude;
                  Key? _markerIdentification = marker.key;

                  int index = tirolEventsList.indexWhere((m) =>
                      m.coordinate.longitude == _markerlong &&
                      m.coordinate.latitude == _markerlat &&
                      m.key == _markerIdentification);

                  LatLng _newMarkerCenter =
                      LatLng(_markerlat - 0.05, _markerlong);
                  _mapController.move(_newMarkerCenter, _currentZoom);
                  double itemWidth = containerWidth + 16.0;
                  double markerPositionX = index * itemWidth;
                  double markerContainerCenterX =
                      markerPositionX + (containerWidth / 2);
                  double listViewCenterX =
                      _scrollController.position.viewportDimension / 2;
                  double scrollOffset =
                      markerContainerCenterX - listViewCenterX;
                  _scrollController.animateTo(
                      scrollOffset + (size.width * 0.025),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 300.0,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _markerList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _selectedMarkerIndex = index;
                        double lat = tirolEventsList[_selectedMarkerIndex]
                            .coordinate
                            .latitude;
                        double long = tirolEventsList[_selectedMarkerIndex]
                            .coordinate
                            .longitude;
                        LatLng _newContainerCenter = LatLng(lat - 0.05, long);
                        _mapController.move(_newContainerCenter, _currentZoom);
                      },
                      child: Container(
                        width: size.width * 0.95,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            stops: [0, 0.7],
                            colors: [
                              Colors.white70,
                              Colors.white,
                            ],
                          ),
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8)),
                                  child: CachedNetworkImage(
                                    imageUrl: tirolEventsList[index].imageURL,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                            color: Colors.red),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/images/image-placeholder.jpg'),
                                    width: size.width,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Text(
                                      tirolEventsList[index].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, right: 4.0, top: 4.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                        tirolEventsList[index].description,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 80,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                color: Colors.white.withOpacity(0.9),
                                child: Center(
                                  child: Text(
                                    tirolEventsList[index].date,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  launchUrlString(
                                      tirolEventsList[index].hyperlink,
                                      mode: LaunchMode.externalApplication);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blueAccent,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    color: Colors.white,
                                    Icons.link,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 300,
          right: 16,
          child: Column(
            children: [
              FloatingActionButton(
                heroTag: "btn1",
                backgroundColor: Colors.red,
                onPressed: () {
                  _currentZoom = _currentZoom + 1;
                  _mapController.move(_currentCenter, _currentZoom);
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Colors.red,
                onPressed: () {
                  _currentZoom = _currentZoom - 1;
                  _mapController.move(_currentCenter, _currentZoom);
                },
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
