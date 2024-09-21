import 'package:emerald_mining/model/machine_model.dart';
import 'package:emerald_mining/resource/components/app_button.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:emerald_mining/view_model/mining_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class MachineWidget extends StatefulWidget {
  MachineWidget({
    super.key,
    required this.machine,
    required this.userInvites,
  });

  Machine machine;
  int userInvites;

  @override
  State<MachineWidget> createState() => _MachineWidgetState();
}

class _MachineWidgetState extends State<MachineWidget> {
  @override
  Widget build(BuildContext context) {
    bool isLocked;
    isLocked = widget.machine.requiredInvites > widget.userInvites;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: GradientBoxBorder(
            width: 1.5,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onPrimaryContainer,
                Theme.of(context).colorScheme.primary,
              ],
              begin: Alignment(0.5, 0),
              end: Alignment(0.1, 1),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            2.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppImages.emerald,
                          scale: 1,
                          filterQuality: FilterQuality.high,
                        ),
                        5.horizontalSpace,
                        Text(
                          '${widget.machine.price.toString()} Coins',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        3.horizontalSpace,
                        Text(
                          '${widget.machine.coinsPerHour.toString()} ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 10),
                        ),
                        Text(
                          'emerald coin/hour',
                          style: TextStyle(
                              fontSize: 8,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  AppImages.machineImagesList[(widget.machine.id - 1)],
                  height: 35,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  5.verticalSpace,
                  Divider(
                    thickness: .5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        isLocked ? AppImages.lock : AppImages.unlock,
                        scale: 0.9,
                      ),
                      Text(
                        isLocked
                            ? 'Unlocks on ${(widget.machine.requiredInvites - widget.userInvites).toString()} invites'
                            : "Unlocked",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w700),
                      ),
                      6.horizontalSpace,
                    ],
                  ),
                  5.verticalSpace,
                  Divider(
                    thickness: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            5.verticalSpace,
            Consumer<MiningViewViewModel>(builder: (context, provider, child) {
              return TextButton(
                onPressed: () async {
                  await provider.buyMachineApi(context, widget.machine.id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.h),
                      gradient: LinearGradient(
                        begin: Alignment(1.06, 0),
                        end: Alignment(-0.08, 0),
                        colors: [
                          Theme.of(context).colorScheme.onPrimaryContainer,
                          Theme.of(context).colorScheme.primary
                        ],
                      )),
                  child: Text(
                    isLocked ? 'Locked' : 'Use Now',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                ),
              );
            })

            // AppButton.getButton(
            //   height: 10,
            //   context: context,
            //   child: Text(
            //     'Buy Now',
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodyLarge!
            //         .copyWith(fontWeight: FontWeight.w700, fontSize: 12),
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
    );
  }
}

class MachineWidget2 extends StatelessWidget {
  MachineWidget2({
    super.key,
    required this.machine,
    required this.userInvites,
  });

  Machine machine;
  int userInvites;

  @override
  Widget build(BuildContext context) {
    bool isLocked;
    isLocked = machine.requiredInvites > userInvites;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: GradientBoxBorder(
            width: 1.5,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onPrimaryContainer,
                Theme.of(context).colorScheme.primary,
              ],
              begin: Alignment(0.5, 0),
              end: Alignment(0.1, 1),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            2.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppImages.emerald,
                          scale: 1,
                          filterQuality: FilterQuality.high,
                        ),
                        5.horizontalSpace,
                        Text(
                          '${machine.price.toString()} Coins',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        3.horizontalSpace,
                        Text(
                          '${machine.coinsPerHour.toString()} ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 10),
                        ),
                        Text(
                          'emerald coin/hour',
                          style: TextStyle(
                              fontSize: 8,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  AppImages.machineImagesList[(machine.id - 1)],
                  height: 35,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  5.verticalSpace,
                  Divider(
                    thickness: .5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        isLocked ? AppImages.lock : AppImages.unlock,
                        scale: 0.9,
                      ),
                      Text(
                        isLocked ? 'Locked' : "Unlocked",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      6.horizontalSpace,
                    ],
                  ),
                  5.verticalSpace,
                  Divider(
                    thickness: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            5.verticalSpace,
            TextButton(
              onPressed: isLocked ? () {} : () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.h),
                    gradient: LinearGradient(
                      begin: Alignment(1.06, 0),
                      end: Alignment(-0.08, 0),
                      colors: [
                        Theme.of(context).colorScheme.onPrimaryContainer,
                        Theme.of(context).colorScheme.primary
                      ],
                    )),
                child: Text(
                  'Active',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
            )

            // AppButton.getButton(
            //   height: 10,
            //   context: context,
            //   child: Text(
            //     'Buy Now',
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodyLarge!
            //         .copyWith(fontWeight: FontWeight.w700, fontSize: 12),
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
