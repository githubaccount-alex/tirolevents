import 'package:flutter/material.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TirolEventDetailsPage extends StatelessWidget {
  final TirolEventsEntity tirolEvent;

  const TirolEventDetailsPage({Key? key, required this.tirolEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("Tirol Events"),
      ),
      body: Center(
        child: Container(
          color: Colors.redAccent,
          child: Column(
            children: [
              Center(
                child: Image.network(
                  tirolEvent.imageUrl,
                  width: size.width,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              IntrinsicHeight(
                child: Container(
                  color: Colors.white,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        tirolEvent.title,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              IntrinsicHeight(
                child: Container(
                  color: Colors.white,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      tirolEvent.description,
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.white,
                width: size.width,
                height: 50,
                child: Center(
                  child: Text(
                    tirolEvent.date,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  print("Website ${tirolEvent.hyperlink} would be opened here");
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.link,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
