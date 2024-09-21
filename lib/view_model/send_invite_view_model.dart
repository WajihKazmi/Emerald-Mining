import 'dart:convert';
import 'package:emerald_mining/model/token_model.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/respository/auth/login_repository.dart';
import 'package:emerald_mining/respository/send_coin_repository.dart';
import 'package:emerald_mining/respository/send_invite_repository.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendInviteViewModel with ChangeNotifier {
  final sendInviteRepository = SendInviteRepository();
  final Utils utils = Utils();

  bool _sendInviteLoading = false;
  bool get sendInviteLoading => _sendInviteLoading;

  setSendInviteLoading(bool value) {
    _sendInviteLoading = value;
    notifyListeners();
  }

  Future<void> sendInviteApi(BuildContext context, String email) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();
    final UserViewModel user =
        Provider.of<UserViewModel>(context, listen: false);

    setSendInviteLoading(true);

    try {
      var body = {"email": email};

      final res = await sendInviteRepository.sendInviteApi(body, token);
      final response = json.decode(res['data']);
      setSendInviteLoading(false);

      if (res['data'] != null) {
        print(response);
        await utils.snackbar(response["detail"].toString(), context);
      } else if (res['error'] != null) {
        utils.errorSnackbar(res['error'], context);
      } else {
        utils.errorSnackbar(
            'An unexpected error occurred. Please try again later.', context);
      }
    } catch (error) {
      print('Error: $error');
      utils.errorSnackbar('An unexpected error occurred', context);
      setSendInviteLoading(false);
    }
  }
}
