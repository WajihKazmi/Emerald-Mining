import 'dart:math';

import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/components/app_button.dart';
import 'package:emerald_mining/resource/components/app_text_form_field.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view_model/auth/login_view_model.dart';
import 'package:emerald_mining/view_model/auth/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    Provider.of<SignUpViewModel>(context, listen: false).disposeFields();
    Provider.of<SignUpViewModel>(context, listen: false).initFields();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
       
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Consumer<SignUpViewModel>(
              builder: (context, signUpProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: signUpProvider.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    40.verticalSpace,
                    AppTextFormField(
                      controller: signUpProvider.nameController,
                      hintText: "Name",
                      isPassword: false,
                      keyboardType: TextInputType.name,
                      autofillHints: [AutofillHints.name],
                      validator: signUpProvider.nameValidator,
                    ),
                    18.verticalSpace,
                    AppTextFormField(
                      controller: signUpProvider.emailController,
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      hintText: 'Email',
                      validator: signUpProvider.emailValidator,
                    ),
                    18.verticalSpace,
                    AppTextFormField(
                      controller: signUpProvider.passwordController,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: [AutofillHints.password],
                      hintText: 'Password',
                      validator: signUpProvider.passwordValidator,
                    ),
                    18.verticalSpace,
                    AppTextFormField(
                      controller: signUpProvider.passwordConfirmController,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: [AutofillHints.password],
                      hintText: 'Confirm Password',
                      validator: signUpProvider.confirmPasswordValidator,
                    ),
                    18.verticalSpace,
                    AppTextFormField(
                      controller: signUpProvider.invitationCodeController,
                      isPassword: false,
                      keyboardType: TextInputType.text,
                      autofillHints: [AutofillHints.password],
                      hintText: 'Enter Invitation Code',
                    ),
                    25.verticalSpace,
                    AppButton.getButton(
                      loading: signUpProvider.signUpLoading,
                      context: context,
                      child: Text(
                        'Create an Account',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      ),
                      onPressed: () {
                        signUpProvider.signUpApi(context);
                      },
                    ),
                    10.verticalSpace,
                    TextButton(
                        onPressed: () {
                          AppNavigator.pushNamed(context, RoutesName.login);
                        },
                        child: Text(
                          "I already have an account",
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        )),
                    15.verticalSpace,
                    const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
          }),
        ),
      ),
    );
  }
}
