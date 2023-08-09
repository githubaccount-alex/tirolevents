// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:tirolevents/01_presentation/tirolevent_details/tirolevent_details_page.dart'
    as _i1;
import 'package:tirolevents/01_presentation/tirolevents/tirolevents_page.dart'
    as _i2;
import 'package:tirolevents/03_domain/entities/tirolevents_entity.dart' as _i5;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    TirolEventDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<TirolEventDetailsRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.TirolEventDetailsPage(
          key: args.key,
          tirolEvent: args.tirolEvent,
        ),
      );
    },
    TirolEventsRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.TirolEventsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.TirolEventDetailsPage]
class TirolEventDetailsRoute
    extends _i3.PageRouteInfo<TirolEventDetailsRouteArgs> {
  TirolEventDetailsRoute({
    _i4.Key? key,
    required _i5.TirolEventsEntity tirolEvent,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          TirolEventDetailsRoute.name,
          args: TirolEventDetailsRouteArgs(
            key: key,
            tirolEvent: tirolEvent,
          ),
          initialChildren: children,
        );

  static const String name = 'TirolEventDetailsRoute';

  static const _i3.PageInfo<TirolEventDetailsRouteArgs> page =
      _i3.PageInfo<TirolEventDetailsRouteArgs>(name);
}

class TirolEventDetailsRouteArgs {
  const TirolEventDetailsRouteArgs({
    this.key,
    required this.tirolEvent,
  });

  final _i4.Key? key;

  final _i5.TirolEventsEntity tirolEvent;

  @override
  String toString() {
    return 'TirolEventDetailsRouteArgs{key: $key, tirolEvent: $tirolEvent}';
  }
}

/// generated route for
/// [_i2.TirolEventsPage]
class TirolEventsRoute extends _i3.PageRouteInfo<void> {
  const TirolEventsRoute({List<_i3.PageRouteInfo>? children})
      : super(
          TirolEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'TirolEventsRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
