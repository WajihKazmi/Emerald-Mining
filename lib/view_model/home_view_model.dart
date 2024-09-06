import 'package:emerald_mining/model/user_model.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/coins_view_model.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import '/data/response/api_response.dart';
import '/respository/home_repository.dart';
import '/resource/app_navigator.dart';
import 'services/token_view_model.dart';
import '/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'services/token_view_model.dart';

class HomeViewModel with ChangeNotifier {
  bool _homeLoading = false;
  bool get homeLoading => _homeLoading;

  late User _user;
  User get user => _user;

  int _battery = 1000;
  int get battery => _battery;

  void setHomeLoading(bool value) {
    _homeLoading = value;
    notifyListeners();
  }

  void incrementCoins(BuildContext context) {
    final coinProvider = Provider.of<CoinsViewModel>(context, listen: false);
    if (_battery > 0) {
      _battery -= 1;
      coinProvider.incrementCoins();
    } else {
      Utils().errorSnackbar(context, 'Battery is empty');
    }

    notifyListeners();
  }

  Future<void> loadData(BuildContext context) async {
    setHomeLoading(true);
    try {
      final userProvider = Provider.of<UserViewModel>(context, listen: false);
      final coinProvider = Provider.of<CoinsViewModel>(context, listen: false);

      _user = userProvider.user;
      if (coinProvider.coins == 0) {
        coinProvider.updateCoins(_user.coins);
      }
    } catch (e) {
      print("Error loading data: $e");
    } finally {
      setHomeLoading(false);
    }
  }
}
