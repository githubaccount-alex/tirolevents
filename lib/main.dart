import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '01_presentation/routes/router.dart';
import '01_presentation/tirolevents/tirolevents_page.dart';
import '02_application/tirolevents/tirolevents_bloc.dart';
import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TirolEventsBloc>(),
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        title: "Tirol Events",
      ),
    );
  }
}
