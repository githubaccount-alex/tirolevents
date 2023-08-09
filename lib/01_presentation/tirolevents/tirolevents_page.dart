import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tirolevents/01_presentation/core/custom_button.dart';
import 'package:tirolevents/01_presentation/core/error_message.dart';
import 'package:tirolevents/01_presentation/tirolevents/widgets/tirolevents_body.dart';
import 'package:tirolevents/02_application/tirolevents/tirolevents_bloc.dart';
import '../../02_application/tirolevents/tirolevents_event.dart';
import '../../02_application/tirolevents/tirolevents_state.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TirolEventsPage extends StatelessWidget {
  const TirolEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TirolEventsBloc>(context).add(TirolEventsRequestEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
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
                const SizedBox(
                    height: 80,
                    child: Center(
                      child: CustomButton(),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
