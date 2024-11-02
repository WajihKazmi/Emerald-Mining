import 'package:emerald_mining/main.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view_model/earn_coins_view_model.dart';
import 'package:emerald_mining/view_model/video_runner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: Color.fromARGB(255, 6, 40, 32),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Coming Soon  ',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.w900, fontSize: 35),
                    textAlign: TextAlign.center,
                  ),
                  // Expanded(
                  //   child: Consumer<EarnCoinsViewModel>(
                  //     builder: (context, earnCoinsViewModel, child) {
                  //       if (earnCoinsViewModel.Loading) {
                  //         return const Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }

                  //       if (earnCoinsViewModel.emeraldVideos.isEmpty) {
                  //         return Center(
                  //           child: Text(
                  //             "No new notifications",
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyLarge!
                  //                 .copyWith(
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 17,
                  //                   color: Colors.white.withOpacity(0.8),
                  //                 ),
                  //           ),
                  //         );
                  //       }

                  //       return Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           50.verticalSpace, // Additional spacing after the AppBar

                  //           ListView.builder(
                  //             shrinkWrap: true,
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             itemCount: earnCoinsViewModel.emeraldVideos.length,
                  //             itemBuilder: (context, index) {
                  //               final video =
                  //                   earnCoinsViewModel.emeraldVideos[index];
                  //               return taskTile(() {
                  //                 // Trigger videoPlayer function when "Watch Now" is pressed

                  //                 Provider.of<VideoRunnerProvider>(context,
                  //                         listen: false)
                  //                     .startVideo(context, video.url,
                  //                         video.id.toString(), 5);
                  //               }, video.title, video.coinReward.toString(),
                  //                   AppImages.youtube, false);
                  //             },
                  //           ),

                  //           50.verticalSpace,
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ));
  }

  Widget taskTile(Function() onPressed, String title, String coins, String icon,
      bool isDailyTask) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(icon),
            5.horizontalSpace,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Image.asset(
                      AppImages.emerald,
                      scale: 1.2,
                    ),
                    3.horizontalSpace,
                    Text(
                      "+$coins Coin",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            button(onPressed, isDailyTask ? "Use now" : "Watch Now"),
          ],
        ),
      ),
    );
  }

  Widget button(Function() onPressed, String text) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.h),
          gradient: LinearGradient(
            begin: const Alignment(1.06, 0),
            end: const Alignment(-0.08, 0),
            colors: [
              Theme.of(context).colorScheme.onPrimaryContainer,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 12),
        ),
      ),
    );
  }
}
