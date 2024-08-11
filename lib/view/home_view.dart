import 'package:emerald_mining/main.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              Image.asset(
                AppImages.emerald,
                scale: 0.8,
              ),
              6.horizontalSpace,
              Text(
                'Emerald Mining',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
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
              onPressed: () {},
              icon: Image.asset(
                AppImages.menu,
                fit: BoxFit.fill,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                AppNavigator.pushNamed(context, RoutesName.notification);
              },
              icon: Image.asset(
                AppImages.notification,
                fit: BoxFit.fill,
              ),
            ),
            6.horizontalSpace,
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.lightening,
                    scale: 0.8,
                  ),
                  Text(
                    '896/1000',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              10.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      AppImages.exchange,
                      scale: 0.8,
                    ),
                    Column(
                      children: [
                        Text(
                          'Profit Per Hours',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white.withOpacity(
                                      0.8,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.emerald,
                              scale: 1.2,
                            ),
                            5.horizontalSpace,
                            Text(
                              '+2.17M',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                            ),
                            5.horizontalSpace,
                            Image.asset(
                              AppImages.info,
                              scale: 0.8,
                            ),
                          ],
                        )
                      ],
                    ),
                    Image.asset(
                      AppImages.setting,
                      fit: BoxFit.fill,
                      scale: 0.8,
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.emerald,
                    scale: 0.8,
                  ),
                  5.horizontalSpace,
                  Text(
                    '20,300,48',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
              20.verticalSpace,
              Image.asset(
                AppImages.logo,
                scale: 0.9,
              )
            ],
          ),
        ));
  }
}
