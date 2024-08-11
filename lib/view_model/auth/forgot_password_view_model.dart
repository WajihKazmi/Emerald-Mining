import 'package:emerald_mining/model/token_model.dart';
import 'package:emerald_mining/respository/auth/forget_password_repository.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:flutter/material.dart';
import '/data/response/api_response.dart';
import '/resource/app_navigator.dart';
import '/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class ForgetPasswordViewModel with ChangeNotifier {
  final forgotPasswordRepository = ForgetPasswordRepository();
  
  final formKey = GlobalKey<FormState>();

    bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
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
  
  bool _forgotPasswordLoading = false;
  bool get forgotPasswordLoading => _forgotPasswordLoading;
  final TextEditingController emailController = TextEditingController();

  setForgetPasswordLoading(bool value) {
    _forgotPasswordLoading = value;
    notifyListeners();
  }

  Future<void> forgotPasswordApi(dynamic data, BuildContext context) async {
    setForgetPasswordLoading(true);

    forgotPasswordRepository.forget_passwordApi(data).then((value) {
      setForgetPasswordLoading(false);
      final tokenPreference =
          Provider.of<TokenViewModel>(context, listen: false);
      tokenPreference.saveToken(TokenModel(token: value['token'].toString()));
      AppNavigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setForgetPasswordLoading(false);
    });
  }
}
