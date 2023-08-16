// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:tirolevents/01_presentation/home/home.dart' as _i1;
import 'package:tirolevents/01_presentation/signup/signup_page.dart' as _i2;
import 'package:tirolevents/01_presentation/splash/splash_page.dart' as _i3;
import 'package:tirolevents/01_presentation/tirolevent_details/tirolevent_details_page.dart'
    as _i4;
import 'package:tirolevents/01_presentation/tirolevents/tirolevents_page.dart'
    as _i5;
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart' as _i8;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.SignupPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SplashPage(),
      );
    },
    TirolEventDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<TirolEventDetailsRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.TirolEventDetailsPage(
          key: args.key,
          tirolEvent: args.tirolEvent,
        ),
      );
    },
    TirolEventsRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.TirolEventsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.SignupPage]
class SignupRoute extends _i6.PageRouteInfo<void> {
  const SignupRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.TirolEventDetailsPage]
class TirolEventDetailsRoute
    extends _i6.PageRouteInfo<TirolEventDetailsRouteArgs> {
  TirolEventDetailsRoute({
    _i7.Key? key,
    required _i8.TirolEventsEntity tirolEvent,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          TirolEventDetailsRoute.name,
          args: TirolEventDetailsRouteArgs(
            key: key,
            tirolEvent: tirolEvent,
          ),
          initialChildren: children,
        );

  static const String name = 'TirolEventDetailsRoute';

  static const _i6.PageInfo<TirolEventDetailsRouteArgs> page =
      _i6.PageInfo<TirolEventDetailsRouteArgs>(name);
}

class TirolEventDetailsRouteArgs {
  const TirolEventDetailsRouteArgs({
    this.key,
    required this.tirolEvent,
  });

  final _i7.Key? key;

  final _i8.TirolEventsEntity tirolEvent;

  @override
  String toString() {
    return 'TirolEventDetailsRouteArgs{key: $key, tirolEvent: $tirolEvent}';
  }
}

/// generated route for
/// [_i5.TirolEventsPage]
class TirolEventsRoute extends _i6.PageRouteInfo<void> {
  const TirolEventsRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TirolEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TirolEventsRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
