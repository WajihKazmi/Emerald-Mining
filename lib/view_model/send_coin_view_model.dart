import 'dart:convert';
import 'package:emerald_mining/model/token_model.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/respository/auth/login_repository.dart';
import 'package:emerald_mining/respository/send_coin_repository.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendCoinViewModel with ChangeNotifier {
  final sendCoinRepository = SendCoinRepository();
  final Utils utils = Utils();

 // final formKey = GlobalKey<FormState>();

  bool _sendCoinLoading = false;
  bool get sendCoinLoading => _sendCoinLoading;

  setSendCoinLoading(bool value) {
    _sendCoinLoading = value;
    notifyListeners();
  }

  Future<void> sendCoinApi(BuildContext context, String userName,
      int coins) async {
    // if (!formKey.currentState!.validate()) {
    //   return;
    // }
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();

    setSendCoinLoading(true);

    try {
      var body = {
        "recipient_username": userName,
        "coins": coins,
      };

      final res = await sendCoinRepository.sendCoinApi(body, token);
      final response = json.decode(res['data']);

      print(response);
      setSendCoinLoading(false);

      if (res['data'] != null) {
        await utils.snackbar('Successfully sent coins!', context);
        AppNavigator.pushNamed(context, RoutesName.bottomNav);
      } else if (res['error'] != null) {
        utils.errorSnackbar(res['error'], context);
      } else {
        utils.errorSnackbar(
            'An unexpected error occurred. Please try again later.', context);
      }
    } catch (error) {
      print('Error: $error');
      utils.errorSnackbar('An unexpected error occurred', context);
      setSendCoinLoading(false);
    }
  }

  // Validator for Username
  String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

 

  // Validator for Coins
  String? validateCoins(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Number of coins cannot be empty';
    }
    int? coins = int.tryParse(value.trim());
    if (coins == null || coins <= 0) {
      return 'Coins must be a positive integer';
    }
    return null;
  }
}
