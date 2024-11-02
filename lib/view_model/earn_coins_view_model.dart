import 'dart:convert';

import 'package:emerald_mining/model/daily_task_model.dart';
import 'package:emerald_mining/model/emerald_videos_model.dart';
import 'package:emerald_mining/model/machine_model.dart';
import 'package:emerald_mining/model/social_account_task_model.dart';
import 'package:emerald_mining/model/user_model.dart';
import 'package:emerald_mining/respository/earn_coin_repository.dart';
import 'package:emerald_mining/respository/mining_repository.dart';
import 'package:emerald_mining/respository/user_machines_repository.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class EarnCoinsViewModel with ChangeNotifier {
  final earnCoinRepository = EarnCoinRepository();
  bool _Loading = true;
  bool get Loading => _Loading;
  Utils utils = Utils();

  setLoading(bool value) {
    _Loading = value;
    notifyListeners();
  }

  List<EmeraldVideo> emeraldVideos = [];
  List<DailyTask> dailyTasks = [];
  List<SocialAccountTask> socialTasks = [];

  Future<void> loadData(BuildContext context) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();

    try {
      final res = await earnCoinRepository.youtubeVideosApi(token);
      final res2 = await earnCoinRepository.dailyRewardsApi(token);
      final res3 = await earnCoinRepository.socialAccountApi(token);
      setLoading(false);
      if (res['data'] != null) {
        final response = json.decode(res['data']);
        final response2 = json.decode(res2['data']);
        final response3 = json.decode(res3['data']);

        emeraldVideos = response
            .map<EmeraldVideo>((json) => EmeraldVideo.fromJson(json))
            .toList();
        dailyTasks = response2
            .map<DailyTask>((json) => DailyTask.fromJson(json))
            .toList();
        socialTasks = response3
            .map<SocialAccountTask>((json) => SocialAccountTask.fromJson(json))
            .toList();
      } else {
        print(res['error']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> watchedVideo(BuildContext context, String id) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();
    try {
      final res = await earnCoinRepository.youtubeVideosUseApi(token, id);

      final userProvider = Provider.of<UserViewModel>(context, listen: false);
      final user = userProvider.user;
      await userProvider.userApi(context, user.id);
      loadData(context);
      if (res['data'] != null) {
        final response = json.decode(res['data']);
        print(response);
        utils.snackbar("Coin Added Succesfully", context);
      } else {
        print(res['error']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> socialTaskDone(BuildContext context, String id) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();
    try {
      final res = await earnCoinRepository.socialAccountUseApi(token, id);

      final userProvider = Provider.of<UserViewModel>(context, listen: false);
      final user = userProvider.user;
      await userProvider.userApi(context, user.id);
      loadData(context);
      if (res['data'] != null) {
        final response = json.decode(res['data']);
        print(response);
        utils.snackbar("Coin Added Succesfully", context);
      } else {
        print(res['error']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> claimCoin(BuildContext context, String id) async {
    final String token =
        await Provider.of<TokenViewModel>(context, listen: false).getToken();
    try {
      final res = await earnCoinRepository.dailyRewardUseApi(token, id);
      final userProvider = Provider.of<UserViewModel>(context, listen: false);
      final user = userProvider.user;
      await userProvider.userApi(context, user.id);
      loadData(context);
      if (res['data'] != null) {
        final response = json.decode(res['data']);
        print(response);
        utils.snackbar("Coin Added Succesfully", context);
      } else {
        print(res['error']);
      }
    } catch (e) {
      print(e);
    }
  }
}
