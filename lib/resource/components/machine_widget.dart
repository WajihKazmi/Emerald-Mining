import 'package:emerald_mining/model/machine_model.dart';
import 'package:emerald_mining/resource/components/app_button.dart';
import 'package:emerald_mining/resource/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class MachineWidget extends StatelessWidget {
  MachineWidget({
    super.key,
    required this.machine,
  });

  Machine machine;

  @override
  Widget build(BuildContext context) {
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
                        AppImages.unlock,
                        scale: 0.9,
                      ),
                      Text(
                        'Unlock',
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
              onPressed: () {},
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
                  'Buy Now',
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
