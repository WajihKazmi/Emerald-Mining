import 'dart:convert';

import 'package:emerald_mining/data/network/NetworkApiService.dart';
import 'package:emerald_mining/resource/app_url.dart';
import 'package:emerald_mining/utils/utils.dart';
import 'package:flutter/material.dart';

class MiningRepository {
  final NetworkApiService _apiServices = NetworkApiService();
  Utils utils = Utils();

  Future<Map<String, dynamic>> machinesApi(
      String token, BuildContext context) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.getAllMachines, token);

      // Return response as 'data'
      return {'data': response, 'error': null};
    } catch (e) {
      // Display error message via snackbar
      utils.errorSnackbar(e.toString(), context);

      // Return the error
      return {'data': null, 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getMachineApi(
      String token, dynamic data, BuildContext context) async {
    try {
      dynamic response = await _apiServices.getPostApiResponseWithToken(
          AppUrl.getUserMachines, data, token);

      // Parse the response
      final parsedResponse = json.decode(response);

      if (parsedResponse.containsKey('detail')) {
        // If 'detail' exists, it means the request was successful
        utils.snackbar(parsedResponse['detail'], context);
      } else {
        // Otherwise, show a generic success message
        utils.snackbar('Machine purchased successfully!', context);
      }

      // Return the response data
      return {'data': response, 'error': null};
    } catch (e) {
      // Handle error case and display error message
      utils.errorSnackbar(e.toString(), context);

      // Return the error
      return {'data': null, 'error': e.toString()};
    }
  }
}
