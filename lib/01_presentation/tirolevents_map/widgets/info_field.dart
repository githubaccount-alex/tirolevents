import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

class MapInfoField extends StatelessWidget {
  final TirolEventsEntity tirolEventsEntity;

  const MapInfoField({Key? key, required this.tirolEventsEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Colors.white70,
      child: Column(
        children: [
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: tirolEventsEntity.imageURL,
              placeholder: (context, url) =>
                  const CircularProgressIndicator(color: Colors.red),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/image-placeholder.jpg'),
              width: size.width,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              tirolEventsEntity.title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(
            height: 1.5,
            color: Colors.red,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            tirolEventsEntity.date,
            style: const TextStyle(
                fontSize: 15, color: Colors.black, letterSpacing: 2),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
