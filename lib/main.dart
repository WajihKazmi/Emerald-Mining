import 'dart:io';

import 'package:emerald_mining/view_model/auth/forgot_password_view_model.dart';
import 'package:emerald_mining/view_model/auth/login_view_model.dart';
import 'package:emerald_mining/view_model/auth/sign_up_view_model.dart';
import 'package:emerald_mining/view_model/bottom_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '/utils/routes/routes.dart';
import '/utils/routes/routes_name.dart';
import '/view_model/services/token_view_model.dart';
import 'resource/app_theme.dart';

//for testing
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemStatusBarContrastEnforced: false));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TokenViewModel()),
    ChangeNotifierProvider(create: (_) => LoginViewModel()),
    ChangeNotifierProvider(create: (_) => SignUpViewModel()),
    ChangeNotifierProvider(create: (_) => ForgetPasswordViewModel()),
    ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
            title: 'Emerald Mining',
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            theme: Themes.lightThemeData(),
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoute,
          ));
}
