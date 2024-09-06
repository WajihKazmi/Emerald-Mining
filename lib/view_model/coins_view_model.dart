import 'package:flutter/material.dart';

class CoinsViewModel extends ChangeNotifier {
  int _coins =0;
  int get coins => _coins;

  void updateCoins(int val) {
    _coins = val;
    notifyListeners();
  }

  void incrementCoins() {
    _coins += 5;
    notifyListeners();
  }
}
