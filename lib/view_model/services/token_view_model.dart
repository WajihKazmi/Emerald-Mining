import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/model/token_model.dart';

class TokenViewModel with ChangeNotifier {

  Future<bool> saveToken(TokenModel tokenModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', tokenModel.token!);
    notifyListeners();
    return true;
  }

  Future<String> getToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');

    return token ?? "";
  }

  Future<bool> removeToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
