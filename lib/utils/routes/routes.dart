import 'package:emerald_mining/view/airdrop_view.dart';
import 'package:emerald_mining/view/auth/forgot_password_view.dart';
import 'package:emerald_mining/view/auth/login_view.dart';
import 'package:emerald_mining/view/auth/onboarding_view.dart';
import 'package:emerald_mining/view/auth/sign_up_view.dart';
import 'package:emerald_mining/view/bottom_nav_views.dart';
import 'package:emerald_mining/view/home_view.dart';
import 'package:emerald_mining/view/invitre_friends_view.dart';
import 'package:emerald_mining/view/mining_view.dart';
import 'package:emerald_mining/view/my_mining_machines_view.dart';
import 'package:emerald_mining/view/notification_view.dart';
import 'package:emerald_mining/view/send_coins_view.dart';
import 'package:emerald_mining/view/stock_view.dart';
import 'package:flutter/material.dart';
import '/utils/routes/routes_name.dart';
import '/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    PageRoute pageRoute = PageRoute();
    print('route: ${settings.name}');
    switch (settings.name) {
      case RoutesName.splash:
        return pageRoute.getPageRoute(const SplashView());
      case RoutesName.login:
        return pageRoute.getPageRoute(const LoginScreen());
      case RoutesName.signUp:
        return pageRoute.getPageRoute(const SignUpScreen());
      case RoutesName.bottomNav:
        return pageRoute.getPageRoute(const BottomNavView());
      case RoutesName.forgotPassword:
        return pageRoute.getPageRoute(const ForgotPasswordScreen());
      case RoutesName.onBoarding:
        return pageRoute.getPageRoute(const OnBoardingScreen());
      case RoutesName.home:
        return pageRoute.getPageRoute(const HomeScreen());
      case RoutesName.notification:
        return pageRoute.getPageRoute(const NotificationScreen());
      case RoutesName.airdrop:
        return pageRoute.getPageRoute(const AirDropScreen());
      case RoutesName.mining:
        return pageRoute.getPageRoute(const MiningScreen());
      case RoutesName.myMiningMachines:
        return pageRoute.getPageRoute(const MyMiningMachinesScreen());
      case RoutesName.sendCoins:
        return pageRoute.getPageRoute(const SendCoinsScreen());
      case RoutesName.inviteFriends:
        return pageRoute.getPageRoute(const InviteFriendsScreen());
      case RoutesName.earn:
        return pageRoute.getPageRoute(const EarnScreen());
      default:
        return pageRoute.getDefaultRoute();
    }
  }
}

class PageRoute extends DefaultPageRoute {
  Route getPageRoute(page) => MaterialPageRoute(
        builder: (BuildContext context) => page,
      );
}

class DefaultPageRoute {
  Route getDefaultRoute() => MaterialPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text('No route defined'),
          ),
        );
      });
}
