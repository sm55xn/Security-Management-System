import 'package:flutter/material.dart';

class ProvideData with ChangeNotifier {
  int choice = 1;
  int office = 0;
  String toOffice = "";
  update(int i) {
    choice = i;
    notifyListeners();
  }

  updateToOffice(String i, int j) {
    toOffice = i;
    office = j;
    notifyListeners();
  }
}
