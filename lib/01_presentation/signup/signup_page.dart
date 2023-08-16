import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tirolevents/01_presentation/signup/widgets/signup_form.dart';

import '../../02_application/authbloc/signupformbloc/signupform_bloc.dart';
import '../../injection.dart';

@RoutePage()
class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: BlocProvider(
            create: (context) => sl<SignupformBloc>(), child: const SignupForm()),
      ),
    );
  }
}
