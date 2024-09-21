import '/data/network/BaseApiServices.dart';
import '/data/network/NetworkApiService.dart';
import '/resource/app_url.dart';

class HomeRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<Map<String, dynamic>> coinButtonApi(String token, int id) async {
    try {
      print('${AppUrl.coinButton}$id/click_button/');
      dynamic response = await _apiServices.getPostApiResponseNoBody(
          '${AppUrl.coinButton}$id/click_button/', token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }
}
