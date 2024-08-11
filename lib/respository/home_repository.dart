import '/data/network/BaseApiServices.dart';
import '/data/network/NetworkApiService.dart';
import '/resource/app_url.dart';

class HomeRepository {
  final NetworkApiService _apiServices = NetworkApiService();

  //   ***   this is Get api data   ***

  // Future<HomeModel> fetchHomeApi() async {
  //   try {
  //     dynamic response =
  //         await _apiServices.getGetApiResponse(AppUrl.home);
  //     return response = HomeModel.fromJson(response);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //   ***   this is Post api data   ***

  // Future<dynamic> homeApi(dynamic data) async {
  //   try {
  //     dynamic response =
  //         await _apiServices.getPostApiResponse(AppUrl.home, data);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
