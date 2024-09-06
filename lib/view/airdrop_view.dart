import 'package:emerald_mining/main.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class AirDropScreen extends StatefulWidget {
  const AirDropScreen({super.key});

  @override
  State<AirDropScreen> createState() => _AirDropScreenState();
}

class _AirDropScreenState extends State<AirDropScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              'Airdrop',
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
          ),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppImages.background,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.airDrop,
                    ),
                    10.verticalSpace,
                    Text(
                      'Airdrop Task',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.w900, fontSize: 35),
                      textAlign: TextAlign.center,
                    ),
                    10.verticalSpace,
                    Text(
                      'Task we will write that our EMERALD COIN \nwill be going to launch soon.',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
