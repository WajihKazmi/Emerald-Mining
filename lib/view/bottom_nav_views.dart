import 'package:emerald_mining/model/user_model.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view/airdrop_view.dart';
import 'package:emerald_mining/view/home_view.dart';
import 'package:emerald_mining/view/invitre_friends_view.dart';
import 'package:emerald_mining/view/mining_view.dart';
import 'package:emerald_mining/view/stock_view.dart';
import 'package:emerald_mining/view_model/bottom_nav_view_model.dart';
import 'package:emerald_mining/view_model/services/token_view_model.dart';
import 'package:emerald_mining/view_model/services/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({Key? key}) : super(key: key);

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late User user;
  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const MiningScreen(),
      const InviteFriendsScreen(),
      const EarnScreen(),
      const AirDropScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Consumer<BottomNavViewModel>(builder: (context, provider, child) {
          return Column(
            children: [
              Image.asset(
                AppImages.exchange,
                scale: 0.9,
                height: provider.tabIndex == 0 ? 35 : 32,
              ),
              5.verticalSpace,
              Text(
                "Home",
                style: TextStyle(
                    color: provider.tabIndex == 0
                        ? Color.fromARGB(255, 253, 213, 82)
                        : Colors.white,
                    fontSize: provider.tabIndex == 0 ? 14 : 12,
                    fontWeight: provider.tabIndex == 0
                        ? FontWeight.w600
                        : FontWeight.w500),
              )
            ],
          );
        }),
        //title: ("Home"),
        activeColorPrimary: Color.fromARGB(255, 253, 213, 82),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Consumer<BottomNavViewModel>(builder: (context, provider, child) {
          return Column(
            children: [
              Image.asset(
                AppImages.miningActive,
                scale: 0.9,
                height: 35,
              ),
              5.verticalSpace,
              Text(
                "Mining",
                style: TextStyle(
                    color: provider.tabIndex == 1
                        ? Color.fromARGB(255, 253, 213, 82)
                        : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          );
        }),
        inactiveIcon:
            Consumer<BottomNavViewModel>(builder: (context, provider, child) {
          return Column(
            children: [
              Image.asset(
                AppImages.mining,
                scale: 0.9,
                height: 32,
              ),
              5.verticalSpace,
              Text(
                "Mining",
                style: TextStyle(
                    color: provider.tabIndex == 1
                        ? Color.fromARGB(255, 253, 213, 82)
                        : Colors.white,
                    fontSize: 12),
              )
            ],
          );
        }),
        // title: ("Mining"),
        activeColorPrimary: Color.fromARGB(255, 253, 213, 82),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              AppImages.mainButtonBackground,
              fit: BoxFit.fill,
              scale: 0.8,
            ),
            Center(
              child: Image.asset(
                AppImages.mainButtonActive,
                scale: 0.9,
              ),
            )
          ],
        ),
        inactiveIcon: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              AppImages.mainButtonBackground,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
              scale: 0.8,
            ),
            Center(
              child: Image.asset(
                AppImages.mainButton,
                scale: 0.9,
              ),
            )
          ],
        ),
        contentPadding: 0,
        activeColorPrimary: Theme.of(context).colorScheme.surface,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Consumer<BottomNavViewModel>(builder: (context, provider, child) {
          return Column(
            children: [
              Image.asset(
                AppImages.stockActive,
                scale: 0.9,
                height: 35,
              ),
              5.verticalSpace,
              Text(
                "Earn",
                style: TextStyle(
                    color: provider.tabIndex == 3
                        ? Color.fromARGB(255, 253, 213, 82)
                        : Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          );
        }),
        inactiveIcon:
            Consumer<BottomNavViewModel>(builder: (context, provider, child) {
          return Column(
            children: [
              Image.asset(
                AppImages.stock,
                scale: 0.9,
                height: 32,
              ),
              5.verticalSpace,
              Text(
                "Earn",
                style: TextStyle(
                    color: provider.tabIndex == 3
                        ? Color.fromARGB(255, 253, 213, 82)
                        : Colors.white,
                    fontSize: 12),
              )
            ],
          );
        }),
        //title: ("Earn"),
        activeColorPrimary: Color.fromARGB(255, 253, 213, 82),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Consumer<BottomNavViewModel>(builder: (context, provider, child) {
          return Column(
            children: [
              Image.asset(
                AppImages.emerald,
                scale: 0.9,
                height: provider.tabIndex == 4 ? 35 : 32,
              ),
              5.verticalSpace,
              Text(
                "Airdrop",
                style: TextStyle(
                    color: provider.tabIndex == 4
                        ? Color.fromARGB(255, 253, 213, 82)
                        : Colors.white,
                    fontSize: provider.tabIndex == 4 ? 14 : 12,
                    fontWeight: provider.tabIndex == 4
                        ? FontWeight.w600
                        : FontWeight.w500),
              )
            ],
          );
        }),
        contentPadding: 0,
        // title: ("AirDrop"),
        activeColorPrimary: Color.fromARGB(255, 253, 213, 82),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  void changeIndex(int index) {
    final navController =
        Provider.of<BottomNavViewModel>(context, listen: false);
    navController.changeTabIndex(index);
  }

  @override
  void initState() {
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    user = userProvider.user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildDrawer(context),
      body: PersistentTabView(
        onItemSelected: changeIndex,
        navBarHeight: 75,
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        padding: EdgeInsets.only(top: 5, bottom: 0),
        confineToSafeArea: false,
        backgroundColor: Theme.of(context)
            .colorScheme
            .surface
            .withOpacity(0.7), // Set your desired background color
        handleAndroidBackButtonPress: true,
        neumorphicProperties: NeumorphicProperties(),
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          colorBehindNavBar: Colors.transparent,
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose a style that suits your design
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kToolbarHeight.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.username),
                    Text(
                      'invite ID: ${user.inviteId}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Spacer(),
                Image.asset(
                  AppImages.share,
                  scale: 0.9,
                ),
              ],
            ),
            Divider(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                AppNavigator.pushNamed(context, RoutesName.myMiningMachines);
              },
              child: Row(
                children: [
                  Image.asset(AppImages.machine),
                  10.horizontalSpace,
                  Text("My Mining Machines"),
                  Spacer(),
                  Icon(
                    CupertinoIcons.forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            15.verticalSpace,
            GestureDetector(
              onTap: () {
                AppNavigator.pushNamed(context, RoutesName.sendCoins);
              },
              child: Row(
                children: [
                  Image.asset(AppImages.emerald),
                  10.horizontalSpace,
                  Text("Send Coins"),
                  Spacer(),
                  Icon(
                    CupertinoIcons.forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Provider.of<TokenViewModel>(context, listen: false)
                    .removeToken();
                Navigator.of(context).pushReplacementNamed(RoutesName.login);
              },
              child: Row(
                children: [
                  Image.asset(
                    AppImages.logout,
                  ),
                  10.horizontalSpace,
                  Text(
                    "Logout",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Icon(
                    CupertinoIcons.forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            kBottomNavigationBarHeight.verticalSpace
          ],
        ),
      ),
    );
  }
}
