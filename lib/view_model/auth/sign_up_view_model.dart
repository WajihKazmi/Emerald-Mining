import 'dart:convert';

import 'package:emerald_mining/model/token_model.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/respository/auth/sign_up_repository.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpViewModel with ChangeNotifier {
  final signUpRepository = SignUpRepository();

  Utils utils = Utils();

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 8;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    }
    if (!validateEmail(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    return null;
  }

  Future<void> signUpApi(BuildContext context, String cPassword,
      String password, String email, String username) async {
    var data = {
      "confirm_password": cPassword,
      "password": password,
      "email": email,
      "username": username
    };

    setSignUpLoading(true);

    try {
      final res = await signUpRepository.signUpApi(data);

      setSignUpLoading(false);
      final response = json.decode(res['data']);
      if (res['data'] != null) {
        final tokenPreference =
            Provider.of<TokenViewModel>(context, listen: false);
        tokenPreference.saveToken(TokenModel(token: response['access_token']));
        AppNavigator.pushNamed(context, RoutesName.login);
      } else if (res['error'] != null) {
        String errorMessage = res['error'].toString();

        print(errorMessage);
        // Display error message
        utils.errorSnackbar(
            'An unexpected error occurred. Please try again later.', context);
      } else {
        // Display generic error
        utils.errorSnackbar(
            'An unexpected error occurred. Please try again later.', context);
      }
    } catch (error) {
      print('Error: $error');
      // Display generic error
      utils.errorSnackbar(
          'An unexpected error occurred. Please try again later.', context);
      setSignUpLoading(false);
    }
  }
}
