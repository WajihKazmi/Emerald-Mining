import 'dart:convert';

import 'package:emerald_mining/model/user_model.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/coins_view_model.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import '/respository/home_repository.dart';
import 'services/token_view_model.dart';
import 'package:provider/provider.dart';

class HomeViewModel with ChangeNotifier {
  HomeRepository homeRepository = HomeRepository();
  bool _homeLoading = false;
  bool get homeLoading => _homeLoading;

  bool _isFirstLoad = true;  // New flag to track the first load
  int _battery = 1000;
  int get battery => _battery;

  void setHomeLoading(bool value) {
    _homeLoading = value;
    notifyListeners();
  }

  Future<void> coinButton(BuildContext context) async {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    final coinProvider = Provider.of<CoinsViewModel>(context, listen: false);
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();

    if (_battery > 0) {
      try {
        final res =
            await homeRepository.coinButtonApi(token, userProvider.user.id);

        if (res['data'] != null) {
          final response = json.decode(res['data']);
          _battery = response['energy'];
          coinProvider.updateCoins(response['coins']);
        } else {
          print(res['error']);
        }
      } catch (e) {
        print(e);
      }
    } else {
      Utils().errorSnackbar(context, 'Battery is empty');
    }

    notifyListeners();
  }

  Future<void> loadData(BuildContext context) async {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    final coinProvider = Provider.of<CoinsViewModel>(context, listen: false);

    // Show loading indicator only on the first load
    if (_isFirstLoad) {
      setHomeLoading(true);
    }

    try {
      final user = userProvider.user;
      await userProvider.userApi(context, user.id);
      
      coinProvider.updateCoins(user.coins);
      _battery = user.energy;
    } catch (e) {
      print("Error loading data: $e");
    } finally {
      // Turn off loading only if it's the first load
      if (_isFirstLoad) {
        setHomeLoading(false);
        _isFirstLoad = false;  // Mark the first load as completed
      }
    }
  }
}
