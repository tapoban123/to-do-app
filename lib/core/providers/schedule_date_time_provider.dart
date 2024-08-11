import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleDateTimeProvider extends ChangeNotifier {
  String _currentDate =
      DateFormat("dd/MM/yyyy").format(DateTime.now()).replaceAll("/", "-");
  String _currentTime = DateFormat.jm().format(DateTime.now());

  String get getScheduledDate => _currentDate;
  String get getScheduledTime => _currentTime;

  void changeDate(DateTime newDate) {
    _currentDate =
        DateFormat("dd/MM/yyyy").format(newDate).replaceAll("/", "-");
    notifyListeners();
  }

  void changeTime(DateTime newTime) {
    _currentTime = DateFormat.jm().format(newTime);
    notifyListeners();
  }
}
