import '/data/network/NetworkApiService.dart';
import '/resource/app_url.dart';

class SendInviteRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<Map<String, dynamic>> sendInviteApi(dynamic data, String token) async {
    try {
       dynamic response = await _apiServices.getPostApiResponseWithToken(
        AppUrl.sendInvite,
        data,
        token 
      );
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }
}
