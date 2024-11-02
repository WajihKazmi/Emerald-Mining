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

  bool _loading = true; // Consistent naming
  bool get loading => _loading;

  bool _isFirstLoad = true; // Track if it's the first load

  late User user;
  late List<Machine> machines;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loadData(BuildContext context) async {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();
    user = userProvider.user;

    // Only show loading spinner on the first load
    if (_isFirstLoad) {
      setLoading(true);
    }

    try {
      // Fetch the machines from the API
      final res = await miningRepository.machinesApi(token, context);

      if (res['data'] != null) {
        final response = json.decode(res['data']) as List;
        machines =
            response.map<Machine>((json) => Machine.fromJson(json)).toList();
      } else {
        print(res['error']); // Error handled by repository snackbar
      }
    } catch (e) {
      print("Error loading machines: $e"); // Log the error
    } finally {
      // Only stop the spinner if it was the first load
      if (_isFirstLoad) {
        setLoading(false);
        _isFirstLoad = false; // Mark the first load as done
      }
    }
  }

  Future<void> buyMachineApi(BuildContext context, int id) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();

    try {
      var body = {"user": user.id, "machine": id};

      // Call the repository to make the purchase
      final res = await miningRepository.getMachineApi(token, body, context);
      final userProvider = Provider.of<UserViewModel>(context, listen: false);
      final user1 = userProvider.user;
      await userProvider.userApi(context, user1.id);
      if (res['data'] != null) {
        print('Purchase successful'); // Handle success
      } else {
        print(res['error']); // Error handled by repository snackbar
      }
    } catch (e) {
      print("Error purchasing machine: $e"); // Log the error
    }
  }
}
