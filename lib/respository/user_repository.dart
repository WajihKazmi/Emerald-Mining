import '/data/network/NetworkApiService.dart';
import '/resource/app_url.dart';

class UserRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<Map<String, dynamic>> userApi(int id, String token) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse('${AppUrl.getUser}$id/', token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }
}
