import 'package:emerald_mining/data/network/NetworkApiService.dart';
import 'package:emerald_mining/resource/app_url.dart';

class UserMachinesRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<Map<String, dynamic>> userMachinesApi( String token) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getUserMachines, token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }
}