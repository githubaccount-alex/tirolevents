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
    BlocProvider.of<TirolEventsBloc>(context).add(TirolEventsRequestEvent());

    return BlocListener<AuthBloc, AuthState>(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                        child: BlocBuilder<TirolEventsBloc, TirolEventsState>(
                            bloc: BlocProvider.of<TirolEventsBloc>(context),
                            builder: (context, tirolEventsState) {
                              if (tirolEventsState is TirolEventsInitial) {
                                return const Text("Waiting for button");
                              } else if (tirolEventsState
                                  is TirolEventsStateLoading) {
                                return const CircularProgressIndicator();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 80,
                          child: Center(
                            child: CustomButton(
                                buttonText: 'Reload Events',
                                callback: () {
                                  BlocProvider.of<TirolEventsBloc>(context)
                                      .add(TirolEventsRequestEvent());
                                }),
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                          height: 80,
                          child: Center(
                            child: CustomButton(
                                buttonText: 'Logout',
                                callback: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(SignOutPressedEvent());
                                }),
                          )),
                    ],
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
