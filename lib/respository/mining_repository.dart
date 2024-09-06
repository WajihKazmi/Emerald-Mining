import 'package:emerald_mining/data/network/NetworkApiService.dart';
import 'package:emerald_mining/resource/app_url.dart';

class MiningRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<Map<String, dynamic>> machinesApi( String token) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getAllMachines, token);
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }
}