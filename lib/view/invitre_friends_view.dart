import 'package:emerald_mining/main.dart';
import 'package:emerald_mining/resource/app_navigator.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/utils/routes/routes_name.dart';
import 'package:emerald_mining/view/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              'Invite Friends',
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
          backgroundColor: Color.fromARGB(255, 6, 40, 32),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                (35 + kToolbarHeight).verticalSpace,
                Text(
                  'You and your friend will receive Bonus',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white.withOpacity(
                          0.9,
                        ),
                      ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
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
                                  Image.asset(
                                    AppImages.photo,
                                    scale: 0.9,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Invite a Friend"),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            AppImages.emerald,
                                            scale: 1.2,
                                          ),
                                          Text("  +5000 Coin",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                          2.horizontalSpace,
                                          Text(
                                            'for You and your friend',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: Colors.white
                                                        .withOpacity(
                                                      0.9,
                                                    ),
                                                    fontSize: 9),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.h),
                                      gradient: LinearGradient(
                                        begin: Alignment(1.06, 0),
                                        end: Alignment(-0.08, 0),
                                        colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                          Theme.of(context).colorScheme.primary
                                        ],
                                      )),
                                  child: Text(
                                    'Invite Now',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                  ),
                                ),
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
          ));
    });
  }
}
