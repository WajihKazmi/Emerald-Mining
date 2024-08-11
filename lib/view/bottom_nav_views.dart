import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/view/airdrop_view.dart';
import 'package:emerald_mining/view/home_view.dart';
import 'package:emerald_mining/view_model/bottom_nav_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  List pages = [
    const HomeScreen(),
    const AirDropScreen(), // Ensure this is at the last index
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          color: Theme.of(context)
              .colorScheme
              .onPrimaryContainer
              .withOpacity(0.85),
          buttonBackgroundColor:
              Theme.of(context).colorScheme.onPrimaryContainer,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          items: <Widget>[
            Image.asset(
              AppImages.exchange,
              height: 30,
            ),
            Image.asset(
              AppImages.mining,
              height: 30,
            ),
            Image.asset(
              AppImages.stock,
              height: 30,
            ),
            Image.asset(
              AppImages.emerald,
              height: 30,
            ),
          ],
          animationCurve: Curves.easeInOut,
          letIndexChange: (index) {
            if (index == 3) {
              context.read<BottomNavViewModel>().changeTabIndex(1); // AirDropScreen
            } else {
              context.read<BottomNavViewModel>().changeTabIndex(0); // HomeScreen
            }
            return true;
          },
        ),
        body: Consumer<BottomNavViewModel>(
          builder: (context, value, child) => pages.elementAt(value.tabIndex),
        ),
      ),
    );
  }
}
