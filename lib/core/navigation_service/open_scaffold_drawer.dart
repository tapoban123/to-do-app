import 'package:flutter/material.dart';

class RootScaffold {
  static openDrawer(BuildContext context) {
    print(ModalRoute.of(context)?.settings.name);

    final ScaffoldState? _scaffoldState =
        context.findRootAncestorStateOfType<ScaffoldState>();
    _scaffoldState?.openDrawer();
  }
}
