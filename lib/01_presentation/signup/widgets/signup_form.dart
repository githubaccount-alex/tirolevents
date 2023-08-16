import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../02_application/authbloc/signupformbloc/signupform_bloc.dart';
import '../../../core/failures/auth_failures.dart';
import '../../core/custom_button.dart';
import '../../routes/router.gr.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String _email;
    late String _password;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? validateEmail(String? input) {
      const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

      if (input == null || input.isEmpty) {
        return "please enter email";
      } else if (RegExp(emailRegex).hasMatch(input)) {
        _email = input;
        return null;
      } else {
        return "invalid email format";
      }
    }

    String? validatePassword(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter password";
      } else if (input.length >= 6) {
        _password = input;
        return null;
      } else {
        return "short password";
      }
    }

    String mapFailureMessage(AuthFailure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return "something went wrong";
        case EmailAlreadyInUseFailure:
          return "email already in use";
        case InvalidEmailAndPasswordCombinationFailure:
          return "invalid email and password combination";
        default:
          return "something went wrong";
      }
    }

    // Hört, ob Auth geklappt hat und navigiert zur Page, oder Fehler ausgeben
    return BlocConsumer<SignupformBloc, SignupformState>(
      listenWhen: (p, c) =>
          p.authFailureOrSuccessOption != c.authFailureOrSuccessOption,
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {},
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold((failure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(mapFailureMessage(failure))));
                }, (_) {
                  AutoRouter.of(context).replace(const TirolEventsRoute());
                }));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Welcome",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Please register or sign in",
                style: TextStyle(color: Colors.white, fontSize: 30)
              ),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                cursorColor: Colors.white,
                decoration: const InputDecoration(labelText: "E-Mail"),
                validator: validateEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: validatePassword,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                buttonText: "Sign in",
                callback: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SignupformBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: _email, password: _password));
                  } else {
                    BlocProvider.of<SignupformBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: null, password: null));

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text("invalid input")));
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                buttonText: "Register",
                callback: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SignupformBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: _email, password: _password));
                  } else {
                    BlocProvider.of<SignupformBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: null, password: null));

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text("invalid input")));
                  }
                },
              ),
              if (state.isSubmitting) ...[
                const SizedBox(
                  height: 10,
                ),
                const LinearProgressIndicator()
              ]
            ],
          ),
        );
      },
    );
  }
}
