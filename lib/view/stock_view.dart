import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/view/notification_view.dart';
import 'package:emerald_mining/view_model/context_provider.dart';
import 'package:emerald_mining/view_model/earn_coins_view_model.dart';
import 'package:emerald_mining/view_model/video_runner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  @override
  void initState() {
    super.initState();
    // Load data when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EarnCoinsViewModel>(context, listen: false).loadData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image across the entire screen
          Positioned.fill(
            child: Image.asset(
              AppImages.bg2,
              fit: BoxFit.cover,
              color: const Color.fromARGB(255, 6, 51, 29).withOpacity(0.8),
              colorBlendMode: BlendMode.color,
            ),
          ),

          // Main content with CustomScrollView
          CustomScrollView(
            slivers: [
              // SliverAppBar: Not pinned, collapses when scrolling
              SliverAppBar(
                backgroundColor: Colors.transparent,
                floating: true,
                pinned: false, // Ensure the appbar is not pinned
                snap: false,
                expandedHeight: 100,
                centerTitle: true,
                title: Row(
                  children: [
                    Image.asset(
                      AppImages.emerald,
                      scale: 0.8,
                    ),
                    6.horizontalSpace,
                    Text(
                      'Earn More Coins',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                leadingWidth: 80,
                leading: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  decoration: BoxDecoration(
                    border: GradientBoxBorder(
                        width: 1.5,
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.onPrimaryContainer,
                            Theme.of(context).colorScheme.primary,
                          ],
                          begin: const Alignment(0.5, 0),
                          end: const Alignment(0.1, 1),
                        )),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ));
                    },
                    icon: Image.asset(
                      AppImages.notification,
                      fit: BoxFit.fill,
                    ),
                  ),
                  6.horizontalSpace,
                ],
              ),

              // SliverToBoxAdapter to hold the content below the AppBar
              SliverToBoxAdapter(
                child: Consumer<EarnCoinsViewModel>(
                  builder: (context, earnCoinsViewModel, child) {
                    if (earnCoinsViewModel.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Emerald Video",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                          ),
                          5.verticalSpace,

                          // Check if emeraldVideos list is empty
                          earnCoinsViewModel.emeraldVideos.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "No videos available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      earnCoinsViewModel.emeraldVideos.length,
                                  itemBuilder: (context, index) {
                                    final video =
                                        earnCoinsViewModel.emeraldVideos[index];
                                    return taskTile(() {
                                      // Trigger videoPlayer function when "Watch Now" is pressed
                                      Provider.of<VideoRunnerProvider>(context,
                                              listen: false)
                                          .startVideo(context, video.url,
                                              video.id.toString(), 30);
                                    }, video.title, video.coinReward.toString(),
                                        AppImages.youtube, false);
                                  },
                                ),

                          15.verticalSpace,

                          Text(
                            "Daily Task",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                          ),
                          5.verticalSpace,

                          // Check if dailyTasks list is empty
                          earnCoinsViewModel.dailyTasks.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "No daily tasks available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      earnCoinsViewModel.dailyTasks.length,
                                  itemBuilder: (context, index) {
                                    final task =
                                        earnCoinsViewModel.dailyTasks[index];
                                    return taskTile(() async {
                                      await earnCoinsViewModel.claimCoin(
                                          context, task.id.toString());
                                    }, task.title, task.coinReward.toString(),
                                        AppImages.exchange, true);
                                  },
                                ),

                          50.verticalSpace,
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
