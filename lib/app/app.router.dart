// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i7;
import 'package:flutter/material.dart' as _i6;
import 'package:stacked/stacked.dart' as _i5;
import 'package:stacked_services/stacked_services.dart' as _i4;

import '../core/models/event/event.dart' as _i8;
import '../ui/views/event_details/event_details_view.dart' as _i3;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/startup/startup_view.dart' as _i2;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i4.StackedService.navigatorKey);

class StackedRouterWeb extends _i5.RootStackRouter {
  StackedRouterWeb({_i6.GlobalKey<_i6.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StartupViewRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.StartupView(),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EventDetailsViewRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailsViewArgs>();
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.EventDetailsView(
          key: args.key,
          event: args.event,
        ),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        _i5.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          EventDetailsViewRoute.name,
          path: '/event-details-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i5.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.StartupView]
class StartupViewRoute extends _i5.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i3.EventDetailsView]
class EventDetailsViewRoute extends _i5.PageRouteInfo<EventDetailsViewArgs> {
  EventDetailsViewRoute({
    _i7.Key? key,
    required _i8.Event event,
  }) : super(
          EventDetailsViewRoute.name,
          path: '/event-details-view',
          args: EventDetailsViewArgs(
            key: key,
            event: event,
          ),
        );

  static const String name = 'EventDetailsView';
}

class EventDetailsViewArgs {
  const EventDetailsViewArgs({
    this.key,
    required this.event,
  });

  final _i7.Key? key;

  final _i8.Event event;

  @override
  String toString() {
    return 'EventDetailsViewArgs{key: $key, event: $event}';
  }
}

extension RouterStateExtension on _i4.RouterService {
  Future<dynamic> navigateToHomeView(
      {void Function(_i5.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToStartupView(
      {void Function(_i5.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToEventDetailsView({
    _i7.Key? key,
    required _i8.Event event,
    void Function(_i5.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      EventDetailsViewRoute(
        key: key,
        event: event,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i5.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i5.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithEventDetailsView({
    _i7.Key? key,
    required _i8.Event event,
    void Function(_i5.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      EventDetailsViewRoute(
        key: key,
        event: event,
      ),
      onFailure: onFailure,
    );
  }
}
