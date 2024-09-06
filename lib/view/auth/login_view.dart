import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/components/app_button.dart';
import 'package:emerald_mining/resource/components/app_text_form_field.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view_model/auth/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            AppNavigator.pop(context);
          },
          icon: Image.asset(AppImages.backArrow),
        ),
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            AppImages.bg2,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            colorBlendMode: BlendMode.color,
            color: const Color.fromARGB(255, 6, 51, 29),
            isAntiAlias: true,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Consumer<LoginViewModel>(
                builder: (context, loginProvider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: loginProvider.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (60 + 80).verticalSpace,
                      AppTextFormField(
                        controller: loginProvider.emailController,
                        hintText: "Email",
                        isPassword: false,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                        validator: loginProvider.emailValidator,
                      ),
                      18.verticalSpace,
                      AppTextFormField(
                        controller: loginProvider.passwordController,
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: [AutofillHints.password],
                        hintText: 'Password',
                        validator: loginProvider.passwordValidator,
                      ),
                      12.verticalSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            AppNavigator.pushNamed(
                                context, RoutesName.forgotPassword);
                          },
                          child: Text(
                            'Forgot password?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      25.verticalSpace,
                      AppButton.getButton(
                        loading: loginProvider.loginLoading,
                        context: context,
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                        onPressed: () {
                          loginProvider.loginApi(context);
                          //AppNavigator.pushNamed(context, RoutesName.bottomNav);
                        },
                      ),
                      10.verticalSpace,
                      TextButton(
                          onPressed: () {
                            AppNavigator.pushNamed(context, RoutesName.signUp);
                          },
                          child: Text(
                            "I don't have an account",
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          )),
                      40.verticalSpace,
                      const Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          thickness: 2,
                          
                        ),
                      ),
                      18.verticalSpace,
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Or login with",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.google),
                          25.horizontalSpace,
                          Image.asset(AppImages.facebook),
                          25.horizontalSpace,
                          Image.asset(AppImages.apple),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
