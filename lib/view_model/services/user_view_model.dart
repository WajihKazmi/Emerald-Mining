import 'dart:convert';

import 'package:emerald_mining/model/user_model.dart';
import 'package:emerald_mining/respository/user_repository.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserViewModel with ChangeNotifier {
  final userRepository = UserRepository();
  final Utils utils = Utils();

  bool _userLoading = false;
  bool get userLoading => _userLoading;

  User user = User();

  setUserLoading(bool value) {
    _userLoading = value;
    notifyListeners();
  }

  Future<void> userApi(BuildContext context, int id) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();

    setUserLoading(true);

    try {
      final res = await userRepository.userApi(id, token);
      final response = json.decode(res['data']);
      setUserLoading(false);

      if (res['data'] != null) {
        user = User.fromJson(response);
        notifyListeners();
      } else {
        print(res['error']);
      }
    } catch (error) {
      print('Error: $error');
      setUserLoading(false);
    }
  }
}
