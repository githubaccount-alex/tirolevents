

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tirolevents/01_presentation/tirolevents/tirolevents_page.dart';
import 'package:tirolevents/02_application/tiroleventsbloc/tirolevents_bloc.dart';

import '../../injection.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => sl<TirolEventsBloc>(), child: const TirolEventsPage());
  }
}
