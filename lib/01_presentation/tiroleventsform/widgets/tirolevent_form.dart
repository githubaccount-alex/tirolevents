

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../02_application/tiroleventsformbloc/tiroleventsform_bloc.dart';
import '../../../02_application/tiroleventsformbloc/tiroleventsform_event.dart';
import '../../../02_application/tiroleventsformbloc/tiroleventsform_state.dart';
import '../../core/custom_button.dart';

class TirolEventsForm extends StatelessWidget {
  const TirolEventsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final textEditingControllerTitle = TextEditingController();
    final textEditingControllerDescription = TextEditingController();
    final textEditingControllerDate = TextEditingController();
    final textEditingControllerHyperlink = TextEditingController();
    final textEditingControllerImageURL = TextEditingController();

    late String title;
    late String description;
    late String date;
    late String hyperlink;
    late String imageURL;


    String? validateTitle(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a title";
      } else if (input.length < 30) {
        title = input;
        return null;
      } else {
        return "title too long";
      }
    }

    String? validateDescription(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a description";
      } else if (input.length < 300) {
        description = input;
        return null;
      } else {
        return "description too long";
      }
    }

    String? validateDate(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a date";
      } else if (input.length < 50) {
        date = input;
        return null;
      } else {
        return "date too long";
      }
    }

    String? validateHyperlink(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a link";
      } else if (input.length < 200) {
        hyperlink = input;
        return null;
      } else {
        return "link too long";
      }
    }

    String? validateImageURL(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a imageURL";
      } else if (input.length < 200) {
        imageURL = input;
        return null;
      } else {
        return "imageURL too long";
      }
    }


    return BlocConsumer<TirolEventsFormBloc, TirolEventsFormState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (context, state) {
        textEditingControllerTitle.text = state.tirolEventsEntity.title;
        textEditingControllerDescription.text = state.tirolEventsEntity.description;
        textEditingControllerDate.text = state.tirolEventsEntity.date;
        textEditingControllerHyperlink.text = state.tirolEventsEntity.hyperlink;
        textEditingControllerImageURL.text = state.tirolEventsEntity.imageURL;


      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Form(
            key: formKey,
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: textEditingControllerTitle,
                    cursorColor: Colors.white,
                    validator: validateTitle,
                    maxLength: 100,
                    maxLines: 2,
                    minLines: 1,
                    decoration: InputDecoration(
                        labelText: "Title",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textEditingControllerDescription,
                    cursorColor: Colors.white,
                    validator: validateDescription,
                    maxLength: 300,
                    maxLines: 8,
                    minLines: 5,
                    decoration: InputDecoration(
                        labelText: "Description",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textEditingControllerDate,
                    cursorColor: Colors.white,
                    validator: validateDate,
                    maxLength: 300,
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                        labelText: "Date",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textEditingControllerHyperlink,
                    cursorColor: Colors.white,
                    validator: validateHyperlink,
                    maxLength: 300,
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                        labelText: "Hyperlink",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textEditingControllerImageURL,
                    cursorColor: Colors.white,
                    validator: validateImageURL,
                    maxLength: 300,
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                        labelText: "ImageURL",
                        counterText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      buttonText: "Safe",
                      callback: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<TirolEventsFormBloc>(context)
                              .add(SafePressedEvent(title: title, description: description, date: date, hyperlink: hyperlink, imageURL: imageURL));
                        } else {
                          BlocProvider.of<TirolEventsFormBloc>(context)
                              .add(SafePressedEvent(title: null, description: null, date: null, hyperlink: null, imageURL: null));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                "Invalid Input",
                              )));
                        }
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
