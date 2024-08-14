import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

class RootDrawer {
  static of(BuildContext context) {
    final DrawerControllerState? _drawerControllerState =
        context.findRootAncestorStateOfType<DrawerControllerState>();

    return _drawerControllerState;
  }
}
