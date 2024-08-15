import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  /// Provide that allows in the navigation of pages from the ScaffoldDrawer.
  NavigationProvider();

  int _currentIndex = 0;

  int get currentPageNumber => _currentIndex;

  void navigateToPage(int pageNumber) {
    _currentIndex = pageNumber;

    notifyListeners();
  }
}
