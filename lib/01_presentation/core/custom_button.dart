import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tirolevents/02_application/tirolevents/tirolevents_bloc.dart';

import '../../02_application/tirolevents/tirolevents_event.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => BlocProvider.of<TirolEventsBloc>(context)
          .add(TirolEventsRequestEvent()),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white30),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              "Reload",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
