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
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Use a unique form key for this screen
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
          // Background image
          Image.asset(
            AppImages.bg2,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            colorBlendMode: BlendMode.color,
            color: const Color.fromARGB(255, 6, 51, 29),
            isAntiAlias: false,
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
                  key: _formKey, // Use the unique form key here
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (60 + 80).verticalSpace,
                      AppTextFormField(
                        controller: emailController,
                        hintText: "Email",
                        isPassword: false,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: [AutofillHints.email],
                        validator: loginProvider.emailValidator,
                      ),
                      18.verticalSpace,
                      AppTextFormField(
                        controller: passwordController,
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                        autofillHints: [AutofillHints.password],
                        hintText: 'Password',
                        validator: loginProvider.passwordValidator,
                      ),
                      10.verticalSpace,
                      CheckboxListTile(
                        side: BorderSide(color: Colors.white, width: 1.1),
                        title: Text(
                          "Remember Me",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        value: rememberMe,
                        onChanged: (newValue) {
                          setState(() {
                            rememberMe = newValue ?? false;
                          });
                        },
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Theme.of(context).colorScheme.primary,
                          thickness: .5,
                        ),
                      ),
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
                          // Validate form and call login API
                          if (_formKey.currentState?.validate() ?? false) {
                            loginProvider.loginApi(
                                context,
                                emailController.text,
                                passwordController.text,
                                rememberMe);
                          }
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
                        ),
                      ),
                      40.verticalSpace,
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
