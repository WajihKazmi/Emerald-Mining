import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:emerald_mining/data/app_exceptions.dart';

class NetworkApiService {
  NetworkApiService();

  Future<dynamic> getGetApiResponse(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return returnResponse(response);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (e) {
      throw TimeoutException(
          'Please check your internet connection and try again.');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    try {
      var headers = {'Content-Type': 'application/json'};

      var response = await http.post(Uri.parse(url),
          headers: headers, body: json.encode(data));

      return returnResponse(response);
    } on SocketException catch (e) {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException catch (e) {
      throw TimeoutException(
          'Please check your internet connection and try again.');
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 201:
        return response.body;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
        throw FetchDataException(
            'Server error with status code ${response.statusCode}: ${response.body}');
      case 404:
        throw FetchDataException(
            'Not found error with status code ${response.statusCode}');
      default:
        throw FetchDataException(
            'Unexpected error with status code ${response.statusCode}');
    }
  }
}
