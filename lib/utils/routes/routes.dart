import 'package:emerald_mining/view/airdrop_view.dart';
import 'package:emerald_mining/view/auth/forgot_password_view.dart';
import 'package:emerald_mining/view/auth/login_view.dart';
import 'package:emerald_mining/view/auth/onboarding_view.dart';
import 'package:emerald_mining/view/auth/sign_up_view.dart';
import 'package:emerald_mining/view/bottom_nav_views.dart';
import 'package:emerald_mining/view/home_view.dart';
import 'package:emerald_mining/view/notification_view.dart';
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
