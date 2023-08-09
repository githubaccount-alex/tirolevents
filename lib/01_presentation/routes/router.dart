import 'package:auto_route/auto_route.dart';
import 'package:tirolevents/01_presentation/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TirolEventsRoute.page, path: '/'),
        AutoRoute(page: TirolEventDetailsRoute.page)
      ];
}
