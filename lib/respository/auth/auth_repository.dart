import '/data/network/BaseApiServices.dart';
import '/data/network/NetworkApiService.dart';
import '/resource/app_url.dart';

class AuthRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.login, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.signup, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
