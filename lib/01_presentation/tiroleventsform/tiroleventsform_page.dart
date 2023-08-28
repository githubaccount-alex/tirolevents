import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tirolevents/01_presentation/tiroleventsform/widgets/safe_progress_overlay.dart';
import 'package:tirolevents/01_presentation/tiroleventsform/widgets/tirolevent_form.dart';
import 'package:tirolevents/02_application/tiroleventsformbloc/tiroleventsform_event.dart';
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart';

import '../../02_application/authbloc/authbloc/auth_bloc.dart';
import '../../02_application/tiroleventsformbloc/tiroleventsform_bloc.dart';
import '../../02_application/tiroleventsformbloc/tiroleventsform_state.dart';
import '../../injection.dart';
import '../routes/router.gr.dart';

@RoutePage()
class TirolEventsFormPage extends StatelessWidget {
  final TirolEventsEntity? tirolEventsEntity;

  const TirolEventsFormPage({Key? key, required this.tirolEventsEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateUnauthenticated) {
            AutoRouter.of(context).push(const SignupRoute());
          }
        },
        child: BlocProvider(
          create: (context) => sl<TirolEventsFormBloc>()
            ..add(
                InitializeTirolEventsDetailPage(tirolevent: tirolEventsEntity)),
          child: BlocConsumer<TirolEventsFormBloc, TirolEventsFormState>(
            listenWhen: (p, c) =>
                p.failureOrSuccessOption != c.failureOrSuccessOption,
            listener: (context, state) {
              state.failureOrSuccessOption.fold(
                  () {},
                  (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                      (failure) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("failure"),
                              backgroundColor: Colors.redAccent)),
                      (_) => Navigator.of(context).popUntil((route) =>
                          route.settings.name == TirolEventsRoute.name)));
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.redAccent,
                  centerTitle: true,
                  title: Text(tirolEventsEntity == null
                      ? "Create Event"
                      : "Edit Event"),
                ),
                body: Stack(
                  children: [
                    const TirolEventsForm(),
                    SafeInProgressOverlay(isSaving: state.isSaving)
                  ],
                ),
              );
            },
          ),
        ));
  }
}
