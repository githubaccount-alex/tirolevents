import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../02_application/authbloc/authbloc/auth_bloc.dart';
import '../routes/router.gr.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          // navigate to home
          context.router.replace(const HomeRoute());
        } else if (state is AuthStateUnauthenticated) {
          // navigate to signin
          context.router.replace(const SignupRoute());
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
