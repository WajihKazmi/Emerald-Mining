import 'dart:convert';

import 'package:emerald_mining/model/machine_model.dart';
import 'package:emerald_mining/model/user_model.dart';
import 'package:emerald_mining/respository/mining_repository.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiningViewViewModel with ChangeNotifier {
  final miningRepository = MiningRepository();
  bool _Loading = true;
  bool get Loading => _Loading;

  setLoading(bool value) {
    _Loading = value;
    notifyListeners();
  }

  late User user;
  late List<Machine> machines;

  Future<void> loadData(BuildContext context) async {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();
    user = userProvider.user;
     
    try {
      final res = await miningRepository.machinesApi(token);
      setLoading(false);
      if (res['data'] != null) {
        final response = json.decode(res['data']);
        machines = response.map<Machine>((json) => Machine.fromJson(json)).toList();
        print(response);
      } else {
        print(res['error']);
      }
    } catch (e) {
      print(e);
    }
  }
}
