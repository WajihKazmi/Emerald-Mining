import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/components/machine_widget.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view/notification_view.dart';
import 'package:emerald_mining/view_model/coins_view_model.dart';
import 'package:emerald_mining/view_model/mining_view_view_model.dart';
import 'package:emerald_mining/view_model/user_machine_view_model.dart';

class MiningScreen extends StatefulWidget {
  const MiningScreen({super.key});

  @override
  State<MiningScreen> createState() => _MiningScreenState();
}

class _MiningScreenState extends State<MiningScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initial load
    _loadData();
    // Set up a timer to refresh data every 1 minute
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _loadData();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  void _loadData() {
    Provider.of<MiningViewViewModel>(context, listen: false).loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (outerContext) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 6, 40, 32),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Image.asset(
              AppImages.bg2,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              colorBlendMode: BlendMode.color,
              color: const Color.fromARGB(239, 6, 51, 29),
            ),
            Consumer3<MiningViewViewModel, CoinsViewModel, UserMachineViewModel>(
              builder: (context, provider, coin, profitProvider, child) {
                return provider.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: Colors.transparent,
                            centerTitle: true,
                            pinned: false,
                            expandedHeight: kToolbarHeight * 1.5,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 5),
                              decoration: BoxDecoration(
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
                                  ),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Scaffold.of(outerContext).openDrawer();
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
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
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
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                                    color: Colors.white
                                                        .withOpacity(0.9),
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
                                                  '+${profitProvider.profit}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                ),
                                                5.horizontalSpace,
                                                Image.asset(
                                                  AppImages.info,
                                                  scale: 0.8,
                                                ),
                                              ],
                                            ),
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
                                        coin.coins.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Stock Mine Machine (${profitProvider.userMachines.length.toString()})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return MachineWidget(
                                    machine: provider.machines[index],
                                    userInvites: provider.user.successfulInvites,
                                  );
                                },
                                itemCount: provider.machines.length,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: (kBottomNavigationBarHeight + 20).verticalSpace,
                          )
                        ],
                      );
              },
            ),
          ],
        ),
      );
    });
  }
}
