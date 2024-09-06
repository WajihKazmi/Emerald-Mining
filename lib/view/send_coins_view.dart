import 'package:emerald_mining/main.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/components/app_button.dart';
import 'package:emerald_mining/resource/components/app_text_form_field.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view_model/send_coin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class SendCoinsScreen extends StatefulWidget {
  const SendCoinsScreen({super.key});

  @override
  State<SendCoinsScreen> createState() => _SendCoinsScreenState();
}

class _SendCoinsScreenState extends State<SendCoinsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Send Coins',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white.withOpacity(
                  1,
                ),
                fontWeight: FontWeight.w600),
          ),
          leadingWidth: 80,
          leading: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            decoration: BoxDecoration(
              border: GradientBoxBorder(
                  width: 1.5,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.onPrimaryContainer,
                      Theme.of(context).colorScheme.primary,
                    ],
                    begin: Alignment(0.5, 0),
                    end: Alignment(0.1, 1),
                  )),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: IconButton(
              onPressed: () {
                AppNavigator.pop(context);
              },
              icon: Image.asset(
                AppImages.menu,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        body: Consumer<SendCoinViewModel>(builder: (context, provider, body) {
          return Stack(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      (40 + 80).verticalSpace,
                      AppTextFormField(
                        hintText: "Enter Username",
                        controller: provider.userNameController,
                        isPassword: false,
                        keyboardType: TextInputType.name,
                        validator: provider.validateUsername,
                      ),
                      20.verticalSpace,
                      AppTextFormField(
                        hintText: "Enter User ID",
                        controller: provider.userIDController,
                        isPassword: false,
                        keyboardType: TextInputType.name,
                        validator: provider.validateUserID,
                      ),
                      20.verticalSpace,
                      AppTextFormField(
                        hintText: "Enter Coins",
                        controller: provider.coinController,
                        isPassword: false,
                        keyboardType: TextInputType.number,
                        validator: provider.validateCoins,
                      ),
                      40.verticalSpace,
                      AppButton.getButton(
                          context: context,
                          loading: provider.sendCoinLoading,
                          child: Text(
                            'Send Now',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                          onPressed: () {
                            provider.sendCoinApi(context);
                          })
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
