import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/components/app_button.dart';
import 'package:emerald_mining/resource/components/app_text_form_field.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view_model/auth/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Use a unique form key for this screen
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController invitationCodeController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    invitationCodeController.dispose();
    super.dispose();
  }

  // Custom validator for password confirmation
  String? confirmPasswordValidator(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {},
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
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
            'Create an Account',
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
              isAntiAlias: true,
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Consumer<SignUpViewModel>(
                builder: (context, signUpProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey, // Use the unique form key here
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (40 + 80).verticalSpace,
                          AppTextFormField(
                            controller: nameController,
                            hintText: "Name",
                            isPassword: false,
                            keyboardType: TextInputType.name,
                            autofillHints: [AutofillHints.name],
                            validator: signUpProvider.nameValidator,
                          ),
                          18.verticalSpace,
                          AppTextFormField(
                            controller: emailController,
                            isPassword: false,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: [AutofillHints.email],
                            hintText: 'Email',
                            validator: signUpProvider.emailValidator,
                          ),
                          18.verticalSpace,
                          AppTextFormField(
                            controller: passwordController,
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            autofillHints: [AutofillHints.password],
                            hintText: 'Password',
                            validator: signUpProvider.passwordValidator,
                          ),
                          18.verticalSpace,
                          AppTextFormField(
                            controller: passwordConfirmController,
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            autofillHints: [AutofillHints.password],
                            hintText: 'Confirm Password',
                            validator: confirmPasswordValidator,
                          ),
                          18.verticalSpace,
                          AppTextFormField(
                            controller: invitationCodeController,
                            isPassword: false,
                            keyboardType: TextInputType.text,
                            hintText: 'Enter Invitation Code',
                          ),
                          25.verticalSpace,
                          AppButton.getButton(
                            loading: signUpProvider.signUpLoading,
                            context: context,
                            child: Text(
                              'Create an Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                            ),
                            onPressed: () {
                              // Validate the form and call sign up API
                              if (_formKey.currentState!.validate()) {
                                signUpProvider.signUpApi(
                                  context,
                                  passwordConfirmController.text,
                                  passwordController.text,
                                  emailController.text,
                                  nameController.text,
                                );
                              }
                            },
                          ),
                          10.verticalSpace,
                          TextButton(
                            onPressed: () {
                              AppNavigator.pushNamed(
                                  context, RoutesName.login);
                            },
                            child: Text(
                              "I already have an account",
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                          15.verticalSpace,
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(),
                          ),
                          18.verticalSpace,
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Or continue with",
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
