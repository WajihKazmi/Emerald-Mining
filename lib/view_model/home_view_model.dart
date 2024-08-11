import 'package:flutter/material.dart';
import '/data/response/api_response.dart';
import '/respository/home_repository.dart';
import '/resource/app_navigator.dart';
import 'services/token_view_model.dart';
import '/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'services/token_view_model.dart';

class HomeViewModel with ChangeNotifier {
  final homeRepository = HomeRepository();

  //   ***   this is Get api data   ***

  // ApiResponse<HomeModel> homeModel = ApiResponse.loading();

  // setHomeLoading(ApiResponse<HomeModel> response) {
  //   homeModel = response;
  //   notifyListeners();
  // }

  // Future<void> fetchHomeApi() async {
  //   setHomeLoading(ApiResponse.loading());

  //   homeRepository.fetchHomeApi().then((value) {
  //     setHomeLoading(ApiResponse.completed(value));
  //   }).onError((error, stackTrace) {
  //     setHomeLoading(ApiResponse.error(error.toString()));
  //   });
  // }




  //   ***   this is Post api data   ***

  // bool _homeLoading = false;
  // bool get homeLoading => _homeLoading;

  // setHomeLoading(bool value) {
  //   _homeLoading = value;
  //   notifyListeners();
  // }

  // Future<void> homeApi(dynamic data, BuildContext context) async {
  //   setHomeLoading(true);

  //   homeRepository.homeApi(data).then((value) {
  //     setHomeLoading(false);
  //     final tokenPreference =
  //         Provider.of<TokenViewModel>(context, listen: false);
  //     tokenPreference.saveToken(TokenModel(token: value['token'].toString()));
  //     AppNavigator.pushNamed(context, RoutesName.munawer);
  //   }).onError((error, stackTrace) {
  //     setHomeLoading(false);
  //   });
  // }

}
