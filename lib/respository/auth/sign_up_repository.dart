import '/data/network/NetworkApiService.dart';
import '/resource/app_url.dart';

class SignUpRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      var response = await _apiServices.getPostApiResponse(AppUrl.signup, data);
      print(response);
      return {'data': response, 'error': null};
    } catch (e) {
      return {'data': null, 'error': e};
    }
  }
}
