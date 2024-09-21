import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:emerald_mining/data/app_exceptions.dart';

class NetworkApiService {
  NetworkApiService();

  Future<dynamic> getGetApiResponse(String url, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out. Please try again.');
    } catch (e) {
      // Catch and rethrow only the necessary message
      rethrow;
    }
  }

  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out. Please try again.');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getPostApiResponseWithToken(
      String url, dynamic data, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out. Please try again.');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getPostApiResponseNoBody(String url, String token) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await http.post(Uri.parse(url), headers: headers);
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw FetchDataException('Request timed out. Please try again.');
    } catch (e) {
      rethrow;
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 201:
        return response.body; // Success, return parsed JSON.
      case 400:
        throw BadRequestException(_parseErrorDetail(response.body));
      case 401:
      case 403:
        throw UnauthorisedException(_parseErrorDetail(response.body));
      case 404:
        throw FetchDataException(
            'Not Found: ${_parseErrorDetail(response.body)}');
      case 500:
        throw FetchDataException(
            'Internal Server Error: ${_parseErrorDetail(response.body)}');
      default:
        throw FetchDataException(_parseErrorDetail(response.body));
    }
  }

  // Helper to extract error detail
  String _parseErrorDetail(String responseBody) {
    try {
      final decoded = json.decode(responseBody);
      // Return the 'detail' field if it exists
      return decoded['detail'] ?? 'An error occurred';
    } catch (e) {
      // Fallback in case the error response format is unexpected
      return 'Error occurred, unable to parse response';
    }
  }
}
