import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';
import 'package:auto_route/auto_route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../02_application/authbloc/authbloc/auth_bloc.dart';
import '../../02_application/tiroleventsbloc/tirolevents_bloc.dart';
import '../../02_application/tiroleventsbloc/tirolevents_event.dart';
import '../../injection.dart';

import '../routes/router.gr.dart';

@RoutePage()
class TirolEventDetailsPage extends StatelessWidget {
  final TirolEventsEntity tirolEvent;

  const TirolEventDetailsPage({Key? key, required this.tirolEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateUnauthenticated) {
          AutoRouter.of(context).push(const SignupRoute());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: const Text("Tirol Events"),
        ),
        body: BlocProvider(
          create: (context) => sl<TirolEventsBloc>(),
          child: Center(
            child: Container(
              color: Colors.redAccent,
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: tirolEvent.imageURL,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/image-placeholder.jpg'),
                    width: size.width,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IntrinsicHeight(
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
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
                    height: 10,
                  ),
                  IntrinsicHeight(
                    child: Container(
                      color: Colors.white,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          tirolEvent.description,
                          style: const TextStyle(fontSize: 15),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    width: size.width,
                    height: 50,
                    child: Center(
                      child: Text(
                        tirolEvent.date,
                        style: const TextStyle(fontSize: 15, letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrlString(tirolEvent.hyperlink,
                              mode: LaunchMode.externalApplication);
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
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.link,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          AutoRouter.of(context).push(
                              TirolEventsMapRoute(
                                  tirolEventsEntity: tirolEvent));
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
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.map_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (tirolEvent.isOwnEvent)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                AutoRouter.of(context).push(
                                    TirolEventsFormRoute(
                                        tirolEventsEntity: tirolEvent));
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
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                sl<TirolEventsBloc>().add(DeleteTirolEventEvent(
                                    tirolevent: tirolEvent));
                                AutoRouter.of(context).pop();
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
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
