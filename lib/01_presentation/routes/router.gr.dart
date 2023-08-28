// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:tirolevents/01_presentation/signup/signup_page.dart' as _i1;
import 'package:tirolevents/01_presentation/splash/splash_page.dart' as _i2;
import 'package:tirolevents/01_presentation/tirolevent_details/tirolevent_details_page.dart'
    as _i3;
import 'package:tirolevents/01_presentation/tirolevents/tirolevents_page.dart'
    as _i7;
import 'package:tirolevents/01_presentation/tirolevents_map/tirolevents_map_page.dart'
    as _i5;
import 'package:tirolevents/01_presentation/tirolevents_overview_map/tirolevents_overview_map_page.dart'
    as _i6;
import 'package:tirolevents/01_presentation/tiroleventsform/tiroleventsform_page.dart'
    as _i4;
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart' as _i10;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SignupRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.SignupPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.SplashPage(),
      );
    },
    TirolEventDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<TirolEventDetailsRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.TirolEventDetailsPage(
          key: args.key,
          tirolEvent: args.tirolEvent,
        ),
      );
    },
    TirolEventsFormRoute.name: (routeData) {
      final args = routeData.argsAs<TirolEventsFormRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.TirolEventsFormPage(
          key: args.key,
          tirolEventsEntity: args.tirolEventsEntity,
        ),
      );
    },
    TirolEventsMapRoute.name: (routeData) {
      final args = routeData.argsAs<TirolEventsMapRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.TirolEventsMapPage(
          key: args.key,
          tirolEventsEntity: args.tirolEventsEntity,
        ),
      );
    },
    TirolEventsOverviewMapRoute.name: (routeData) {
      final args = routeData.argsAs<TirolEventsOverviewMapRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.TirolEventsOverviewMapPage(
          key: args.key,
          tiroleventsList: args.tiroleventsList,
        ),
      );
    },
    TirolEventsRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.TirolEventsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.SignupPage]
class SignupRoute extends _i8.PageRouteInfo<void> {
  const SignupRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.TirolEventDetailsPage]
class TirolEventDetailsRoute
    extends _i8.PageRouteInfo<TirolEventDetailsRouteArgs> {
  TirolEventDetailsRoute({
    _i9.Key? key,
    required _i10.TirolEventsEntity tirolEvent,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          TirolEventDetailsRoute.name,
          args: TirolEventDetailsRouteArgs(
            key: key,
            tirolEvent: tirolEvent,
          ),
          initialChildren: children,
        );

  static const String name = 'TirolEventDetailsRoute';

  static const _i8.PageInfo<TirolEventDetailsRouteArgs> page =
      _i8.PageInfo<TirolEventDetailsRouteArgs>(name);
}

class TirolEventDetailsRouteArgs {
  const TirolEventDetailsRouteArgs({
    this.key,
    required this.tirolEvent,
  });

  final _i9.Key? key;

  final _i10.TirolEventsEntity tirolEvent;

  @override
  String toString() {
    return 'TirolEventDetailsRouteArgs{key: $key, tirolEvent: $tirolEvent}';
  }
}

/// generated route for
/// [_i4.TirolEventsFormPage]
class TirolEventsFormRoute extends _i8.PageRouteInfo<TirolEventsFormRouteArgs> {
  TirolEventsFormRoute({
    _i9.Key? key,
    required _i10.TirolEventsEntity? tirolEventsEntity,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          TirolEventsFormRoute.name,
          args: TirolEventsFormRouteArgs(
            key: key,
            tirolEventsEntity: tirolEventsEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'TirolEventsFormRoute';

  static const _i8.PageInfo<TirolEventsFormRouteArgs> page =
      _i8.PageInfo<TirolEventsFormRouteArgs>(name);
}

class TirolEventsFormRouteArgs {
  const TirolEventsFormRouteArgs({
    this.key,
    required this.tirolEventsEntity,
  });

  final _i9.Key? key;

  final _i10.TirolEventsEntity? tirolEventsEntity;

  @override
  String toString() {
    return 'TirolEventsFormRouteArgs{key: $key, tirolEventsEntity: $tirolEventsEntity}';
  }
}

/// generated route for
/// [_i5.TirolEventsMapPage]
class TirolEventsMapRoute extends _i8.PageRouteInfo<TirolEventsMapRouteArgs> {
  TirolEventsMapRoute({
    _i9.Key? key,
    required _i10.TirolEventsEntity tirolEventsEntity,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          TirolEventsMapRoute.name,
          args: TirolEventsMapRouteArgs(
            key: key,
            tirolEventsEntity: tirolEventsEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'TirolEventsMapRoute';

  static const _i8.PageInfo<TirolEventsMapRouteArgs> page =
      _i8.PageInfo<TirolEventsMapRouteArgs>(name);
}

class TirolEventsMapRouteArgs {
  const TirolEventsMapRouteArgs({
    this.key,
    required this.tirolEventsEntity,
  });

  final _i9.Key? key;

  final _i10.TirolEventsEntity tirolEventsEntity;

  @override
  String toString() {
    return 'TirolEventsMapRouteArgs{key: $key, tirolEventsEntity: $tirolEventsEntity}';
  }
}

/// generated route for
/// [_i6.TirolEventsOverviewMapPage]
class TirolEventsOverviewMapRoute
    extends _i8.PageRouteInfo<TirolEventsOverviewMapRouteArgs> {
  TirolEventsOverviewMapRoute({
    _i9.Key? key,
    required List<_i10.TirolEventsEntity> tiroleventsList,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          TirolEventsOverviewMapRoute.name,
          args: TirolEventsOverviewMapRouteArgs(
            key: key,
            tiroleventsList: tiroleventsList,
          ),
          initialChildren: children,
        );

  static const String name = 'TirolEventsOverviewMapRoute';

  static const _i8.PageInfo<TirolEventsOverviewMapRouteArgs> page =
      _i8.PageInfo<TirolEventsOverviewMapRouteArgs>(name);
}

class TirolEventsOverviewMapRouteArgs {
  const TirolEventsOverviewMapRouteArgs({
    this.key,
    required this.tiroleventsList,
  });

  final _i9.Key? key;

  final List<_i10.TirolEventsEntity> tiroleventsList;

  @override
  String toString() {
    return 'TirolEventsOverviewMapRouteArgs{key: $key, tiroleventsList: $tiroleventsList}';
  }
}

/// generated route for
/// [_i7.TirolEventsPage]
class TirolEventsRoute extends _i8.PageRouteInfo<void> {
  const TirolEventsRoute({List<_i8.PageRouteInfo>? children})
      : super(
          TirolEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TirolEventsRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
