import 'package:flutter/material.dart';

/// Implements a NavigatorKey.
///
/// Utilised in places where navigation was necessary without a BuildContext.
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

/// A small piece of code that is called to open or close a ScaffoldDrawer.
class RootDrawer {
  static of(BuildContext context) {
    final DrawerControllerState? _drawerControllerState =
        context.findRootAncestorStateOfType<DrawerControllerState>();

    return _drawerControllerState;
  }
}
