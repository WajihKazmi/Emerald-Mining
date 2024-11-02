import 'package:emerald_mining/data/network/NetworkApiService.dart';
import 'package:emerald_mining/resource/app_url.dart';

class EarnCoinRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<Map<String, dynamic>> youtubeVideosApi(String token) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.videos, token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }

  Future<Map<String, dynamic>> youtubeVideosUseApi(
      String token, String id) async {
    try {
      dynamic response = await _apiServices.getPostApiResponseNoBody(
          '${AppUrl.videos}$id/watch/', token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }

  Future<Map<String, dynamic>> dailyRewardsApi(String token) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.dailyReward, token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }

  Future<Map<String, dynamic>> dailyRewardUseApi(
      String token, String id) async {
    try {
      dynamic response = await _apiServices.getPostApiResponseNoBody(
          '${AppUrl.dailyReward}$id/use/', token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }

  Future<Map<String, dynamic>> socialAccountApi(String token) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          AppUrl.socialAccountsTask, token);
          print(response);
      return {'data': response, 'error': null};
      
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }

  Future<Map<String, dynamic>> socialAccountUseApi(
      String token, String id) async {
    try {
      dynamic response = await _apiServices.getPostApiResponseNoBody(
          '${AppUrl.socialAccountsTask}$id/complete/', token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }
}
