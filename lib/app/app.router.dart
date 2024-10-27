// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i11;
import 'package:flutter/material.dart' as _i10;
import 'package:stacked/stacked.dart' as _i9;
import 'package:stacked_services/stacked_services.dart' as _i8;

import '../core/models/event/event.dart' as _i12;
import '../ui/views/details_form/details_form_view.dart' as _i5;
import '../ui/views/event_details/event_details_view.dart' as _i3;
import '../ui/views/home/home_view.dart' as _i1;
import '../ui/views/map_navigation/map_navigation_view.dart' as _i6;
import '../ui/views/search_view/search_view_view.dart' as _i7;
import '../ui/views/startup/startup_view.dart' as _i2;
import '../ui/views/ticket_selection/ticket_selection_view.dart' as _i4;

final stackedRouter =
    StackedRouterWeb(navigatorKey: _i8.StackedService.navigatorKey);

class StackedRouterWeb extends _i9.RootStackRouter {
  StackedRouterWeb({_i10.GlobalKey<_i10.NavigatorState>? navigatorKey})
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    HomeViewRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    StartupViewRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.StartupView(),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    EventDetailsViewRoute.name: (routeData) {
      final args = routeData.argsAs<EventDetailsViewArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.EventDetailsView(
          key: args.key,
          event: args.event,
        ),
      );
    },
    TicketSelectionViewRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.TicketSelectionView(),
        transitionsBuilder: _i9.TransitionsBuilders.slideBottom,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DetailsFormViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.DetailsFormView(),
      );
    },
    MapNavigationViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.MapNavigationView(),
        fullscreenDialog: true,
      );
    },
    SearchViewRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.SearchView(),
        fullscreenDialog: true,
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          HomeViewRoute.name,
          path: '/home-view',
        ),
        _i9.RouteConfig(
          StartupViewRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          EventDetailsViewRoute.name,
          path: '/event-details-view',
        ),
        _i9.RouteConfig(
          TicketSelectionViewRoute.name,
          path: '/ticket-selection-view',
        ),
        _i9.RouteConfig(
          DetailsFormViewRoute.name,
          path: '/details-form-view',
        ),
        _i9.RouteConfig(
          MapNavigationViewRoute.name,
          path: '/map-navigation-view',
        ),
        _i9.RouteConfig(
          SearchViewRoute.name,
          path: '/search-view',
        ),
      ];
}

/// generated route for
/// [_i1.HomeView]
class HomeViewRoute extends _i9.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: '/home-view',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i2.StartupView]
class StartupViewRoute extends _i9.PageRouteInfo<void> {
  const StartupViewRoute()
      : super(
          StartupViewRoute.name,
          path: '/',
        );

  static const String name = 'StartupView';
}

/// generated route for
/// [_i3.EventDetailsView]
class EventDetailsViewRoute extends _i9.PageRouteInfo<EventDetailsViewArgs> {
  EventDetailsViewRoute({
    _i11.Key? key,
    required _i12.Event event,
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

  final _i11.Key? key;

  final _i12.Event event;

  @override
  String toString() {
    return 'EventDetailsViewArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [_i4.TicketSelectionView]
class TicketSelectionViewRoute extends _i9.PageRouteInfo<void> {
  const TicketSelectionViewRoute()
      : super(
          TicketSelectionViewRoute.name,
          path: '/ticket-selection-view',
        );

  static const String name = 'TicketSelectionView';
}

/// generated route for
/// [_i5.DetailsFormView]
class DetailsFormViewRoute extends _i9.PageRouteInfo<void> {
  const DetailsFormViewRoute()
      : super(
          DetailsFormViewRoute.name,
          path: '/details-form-view',
        );

  static const String name = 'DetailsFormView';
}

/// generated route for
/// [_i6.MapNavigationView]
class MapNavigationViewRoute extends _i9.PageRouteInfo<void> {
  const MapNavigationViewRoute()
      : super(
          MapNavigationViewRoute.name,
          path: '/map-navigation-view',
        );

  static const String name = 'MapNavigationView';
}

/// generated route for
/// [_i7.SearchView]
class SearchViewRoute extends _i9.PageRouteInfo<void> {
  const SearchViewRoute()
      : super(
          SearchViewRoute.name,
          path: '/search-view',
        );

  static const String name = 'SearchView';
}

extension RouterStateExtension on _i8.RouterService {
  Future<dynamic> navigateToHomeView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToStartupView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToEventDetailsView({
    _i11.Key? key,
    required _i12.Event event,
    void Function(_i9.NavigationFailure)? onFailure,
  }) async {
    return navigateTo(
      EventDetailsViewRoute(
        key: key,
        event: event,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToTicketSelectionView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const TicketSelectionViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToDetailsFormView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const DetailsFormViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToMapNavigationView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const MapNavigationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> navigateToSearchView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return navigateTo(
      const SearchViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithHomeView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const HomeViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithStartupView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const StartupViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithEventDetailsView({
    _i11.Key? key,
    required _i12.Event event,
    void Function(_i9.NavigationFailure)? onFailure,
  }) async {
    return replaceWith(
      EventDetailsViewRoute(
        key: key,
        event: event,
      ),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithTicketSelectionView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const TicketSelectionViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithDetailsFormView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const DetailsFormViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithMapNavigationView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const MapNavigationViewRoute(),
      onFailure: onFailure,
    );
  }

  Future<dynamic> replaceWithSearchView(
      {void Function(_i9.NavigationFailure)? onFailure}) async {
    return replaceWith(
      const SearchViewRoute(),
      onFailure: onFailure,
    );
  }
}
