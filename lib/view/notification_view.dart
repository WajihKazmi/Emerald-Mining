import 'package:emerald_mining/main.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Notification',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white.withOpacity(
                    0.9,
                  ),
                ),
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
          actions: [
            IconButton(
              onPressed: () {
                AppNavigator.pop(context);
              },
              icon: Image.asset(
                AppImages.notification,
                fit: BoxFit.fill,
              ),
            ),
            6.horizontalSpace,
          ],
        ),
        body: Stack(
          children: [
            Image.asset(
              AppImages.background,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
              width: MediaQuery.sizeOf(context).width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  20.verticalSpace,
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(AppImages.youtube),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        'You will get +100000 Coin For Watching Youtube Video',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  AppImages.emerald,
                                  scale: 0.75,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
