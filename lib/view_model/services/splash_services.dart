import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/utils/routes/routes_name.dart';
import '/view_model/services/token_view_model.dart';
import '/model/token_model.dart';
import '/resource/app_navigator.dart';

class SplashServices {


 

  // void checkAuthentication(BuildContext context)async{
  //   // await Future.delayed(const Duration(seconds: 2));
  //   //     AppNavigator.pushNamed(context, RoutesName.onBoarding);


    

  // }
  Future<void> checkLoginStatus(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? tokenCreationDate = prefs.getString('tokenCreationDate');

  if (token != null && tokenCreationDate != null) {
    DateTime creationDate = DateTime.parse(tokenCreationDate);
    final currentDate = DateTime.now();

    // Check if the token is older than 3 days
    if (currentDate.difference(creationDate).inDays > 3) {
      // Token expired, navigate to login
      Navigator.of(context).pushReplacementNamed(RoutesName.login);
    } else {
      // Token is still valid, run get user API and navigate to home
      String? userId = prefs.getString('userId');
      if (userId != null) {
        final userProvider =
            Provider.of<UserViewModel>(context, listen: false);
        await userProvider.userApi(context, int.parse(userId));
        Navigator.of(context).pushReplacementNamed(RoutesName.bottomNav);
      }
    }
  } else {
    // No token, navigate to login
    Navigator.of(context).pushReplacementNamed(RoutesName.login);
  }
}



}




// getTokenDate().then((value)async{

    //   print(value.token.toString());

    //   if(value.token.toString() == 'null' || value.token.toString() == ''){
    //     await Future.delayed(const Duration(seconds: 2));
    //     AppNavigator.pushNamed(context, RoutesName.login);
    //   }else {
    //     await  Future.delayed(const Duration(seconds: 2));
    //     AppNavigator.pushNamed(context, RoutesName.home);
    //   }

    // }).onError((error, stackTrace){
    //   if(kDebugMode){
    //     print(error.toString());
    //   }
    // });