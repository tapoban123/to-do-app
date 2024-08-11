import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentPageNumber => _currentIndex;

  void navigateToPage(int pageNumber) {
    _currentIndex = pageNumber;

    notifyListeners();
  }
}
