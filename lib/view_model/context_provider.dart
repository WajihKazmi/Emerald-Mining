import 'package:flutter/material.dart';

class ContextProvider extends ChangeNotifier {
  late BuildContext context;

  void setContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }
}
