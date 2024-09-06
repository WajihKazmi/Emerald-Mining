import 'package:emerald_mining/main.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view/notification_view.dart';
import 'package:emerald_mining/view_model/coins_view_model.dart';
import 'package:emerald_mining/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Import to use Haptic Feedback

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);

    // Load data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).loadData(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    HapticFeedback.lightImpact();
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    Provider.of<HomeViewModel>(context, listen: false).incrementCoins(context);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 6, 40, 32),
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context),
        body: Consumer2<HomeViewModel, CoinsViewModel>(
            builder: (context, provider, coins, child) {
          if (provider.homeLoading) {
            //loading indicator
            return Center(child: CircularProgressIndicator());
          } else {
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
                  child: Column(
                    children: [
                      (kToolbarHeight + 20).verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.lightening,
                            scale: 0.8,
                          ),
                          Text(
                            '${provider.battery}/1000',
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
                                  Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w600,
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
                                            fontWeight: FontWeight.w900,
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
                            coins.coins.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        ],
                      ),
                      20.verticalSpace,
                      GestureDetector(
                        onTapDown: _onTapDown,
                        onTapUp: _onTapUp,
                        child: ScaleTransition(
                          scale: _animation,
                          child: Image.asset(
                            AppImages.emeraldButton,
                            scale: 0.9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      );
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
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
              builder: (context) => NotificationScreen(),
            ));
          },
          icon: Image.asset(
            AppImages.notification,
            fit: BoxFit.fill,
          ),
        ),
        6.horizontalSpace,
      ],
    );
  }
}
