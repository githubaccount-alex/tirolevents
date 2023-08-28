import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../02_application/tiroleventsbloc/tirolevents_bloc.dart';
import '../../02_application/tiroleventsbloc/tirolevents_event.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function callback;
  const CustomButton({Key? key, required this.buttonText, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => callback(),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ),
    );
  }
}
