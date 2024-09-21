import 'dart:convert';

import 'package:emerald_mining/model/machine_model.dart';
import 'package:emerald_mining/model/user_machine_model.dart';
import 'package:emerald_mining/model/user_model.dart';
import 'package:emerald_mining/respository/mining_repository.dart';
import 'package:emerald_mining/respository/user_machines_repository.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserMachineViewModel with ChangeNotifier {
  final userMachineRepository = UserMachinesRepository();
  bool _Loading = true;
  bool get Loading => _Loading;
  Utils utils = Utils();

  List<UserMachine> userMachines = [];
  int profit = 0;

  setLoading(bool value) {
    _Loading = value;
    notifyListeners();
  }

  Future<void> loadData(BuildContext context) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();

    try {
      final res = await userMachineRepository.userMachinesApi(token);
      setLoading(false);
      if (res['data'] != null) {
        final response = json.decode(res['data']);

        userMachines = response
            .map<UserMachine>((json) => UserMachine.fromJson(json))
            .toList();
        profit = 0;
        for (var val in userMachines) {
          profit += val.machine.coinsPerHour;
        }

        print(response);
      } else {
        print(res['error']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> collectCoins(BuildContext context, int id) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();

    try {
      final res = await userMachineRepository.collectUserMachineApi(token, id);
      setLoading(false);
      if (res['data'] != null) {
        final response = json.decode(res['data']);
        print(response);
      } else {
        print(res['error']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> collectAll(BuildContext context) async {
    for (var machine in userMachines) {
      await collectCoins(context, machine.id);
    }
    utils.snackbar("Successfully Collected Coins", context);

    // Save the current time as the last collection time in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'lastCollectionTime', DateTime.now().millisecondsSinceEpoch);
  }

  Future<int?> getLastCollectionTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lastCollectionTime');
  }
}
