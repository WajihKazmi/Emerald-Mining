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

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 6, 40, 32),
          extendBodyBehindAppBar: true,
          appBar: buildAppBar(context),
          body: Center(
            child: Text(
              "Coming Soon",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ));
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
