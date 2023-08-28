import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tirolevents/01_presentation/core/custom_button.dart';
import 'package:tirolevents/01_presentation/core/error_message.dart';
import 'package:tirolevents/01_presentation/tirolevents/widgets/tirolevents_body.dart';
import 'package:auto_route/auto_route.dart';

import '../../02_application/authbloc/authbloc/auth_bloc.dart';
import '../../02_application/tiroleventsbloc/tirolevents_bloc.dart';
import '../../02_application/tiroleventsbloc/tirolevents_event.dart';
import '../../02_application/tiroleventsbloc/tirolevents_state.dart';
import '../../injection.dart';
import '../routes/router.gr.dart';

@RoutePage()
class TirolEventsPage extends StatelessWidget {
  const TirolEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = sl<TirolEventsBloc>()..add(TirolEventsRequestEvent());

    return BlocProvider<TirolEventsBloc>(
      create: (context) => bloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateUnauthenticated) {
            AutoRouter.of(context).push(const SignupRoute());
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text("Tirol Events"),
          ),
          body: Center(
            child: Container(
              color: Colors.redAccent,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: BlocBuilder<TirolEventsBloc, TirolEventsState>(
                              bloc: bloc,
                              builder: (context, tirolEventsState) {
                                if (tirolEventsState is TirolEventsInitial) {
                                  return const CircularProgressIndicator(color: Colors.white);
                                } else if (tirolEventsState
                                    is TirolEventsStateLoading) {
                                  return const CircularProgressIndicator(color: Colors.white);
                                } else if (tirolEventsState
                                    is TirolEventsStateLoaded) {
                                  return TirolEventsBody(
                                      tirolEvents:
                                          tirolEventsState.tirolEventsList);
                                } else if (tirolEventsState
                                    is TirolEventsStateError) {
                                  return ErrorMessage(
                                      message: tirolEventsState.message);
                                }
                                return const Placeholder();
                              })),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0.7],
                        colors: [
                          Colors.transparent,
                          Colors.black26
                          //Colors.white70,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              bloc.add(TirolEventsRequestEvent());
                            },
                            child: Container(
                              width: 40,
                              height: 40,
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
                                Icons.downloading,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignOutPressedEvent());
                            },
                            child: Container(
                              width: 40,
                              height: 40,
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
                                Icons.logout,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              AutoRouter.of(context).push(TirolEventsFormRoute(
                                  tirolEventsEntity: null));
                            },
                            child: Container(
                              width: 40,
                              height: 40,
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
                                Icons.add,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              AutoRouter.of(context).push(
                                  TirolEventsOverviewMapRoute(
                                      tiroleventsList: bloc.allEvents));
                            },
                            child: Container(
                              width: 40,
                              height: 40,
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
