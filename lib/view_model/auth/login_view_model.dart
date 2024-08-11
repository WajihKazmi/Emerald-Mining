import 'dart:convert';
import 'package:emerald_mining/model/token_model.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/respository/auth/login_repository.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel with ChangeNotifier {
  final loginRepository = LoginRepository();
  final Utils utils = Utils();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _loginLoading = false;
  bool get loginLoading => _loginLoading;

  setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 6; // Updated to 8 characters
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email.';
    }
    if (!validateEmail(email)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password.';
    }
    if (!validatePassword(password)) {
      return 'Password must be at least 8 characters long.';
    }
    return null;
  }

  Future<void> loginApi(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String email = emailController.text;
    String password = passwordController.text;

    setLoginLoading(true);

    try {
      var body = {"email": email, "password": password};

      final res = await loginRepository.loginApi(body);
      final response = json.decode(res['data']);
      setLoginLoading(false);

      if (res['data'] != null) {
        final tokenPreference =
            Provider.of<TokenViewModel>(context, listen: false);
        tokenPreference
            .saveToken(TokenModel(token: response['access'].toString()));
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
      setLoginLoading(false);
    }
  }
}
