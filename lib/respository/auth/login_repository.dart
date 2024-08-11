import 'dart:convert';

import 'package:dio/dio.dart';

import '/data/network/NetworkApiService.dart';
import '/resource/app_url.dart';

class LoginRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  Future<Map<String, dynamic>> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.login,
        data, // Encode the data using jsonEncode
      );
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle other exceptions
      return {'data': null, 'error': e};
    }
  }
}
