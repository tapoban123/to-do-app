import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<void> navigateTo(Widget routePage) {
    return navigatorKey.currentState!.push(MaterialPageRoute(
      builder: (context) => routePage,
    ));
  }
}

class RootDrawer {
  static of(BuildContext context) {
    final DrawerControllerState? _drawerControllerState =
        context.findRootAncestorStateOfType<DrawerControllerState>();

    return _drawerControllerState;
  }
}
