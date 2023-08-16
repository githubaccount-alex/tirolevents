import 'package:auto_route/auto_route.dart';
import 'package:tirolevents/01_presentation/routes/router.gr.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/'),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: TirolEventsRoute.page),
        AutoRoute(page: TirolEventDetailsRoute.page),
        AutoRoute(page: SignupRoute.page)
      ];
}
