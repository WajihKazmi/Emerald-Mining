import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton {
  static Widget getButton({
    required BuildContext context,
    required Widget? child,
    required void Function()? onPressed,
    double? width,
    double? height,
    Color? color,
    double? radius,
    bool loading = false,
  }) =>
      Container(
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
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius?.r ?? 30.0.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              backgroundColor: Colors.transparent,
              // minimumSize:
              //     Size(width?.w ?? double.infinity.w, height?.h ?? 50.0.h),
            ),
            onPressed: loading == true ? null : onPressed,
            child: loading
                ? CircularProgressIndicator.adaptive(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  )
                : child),
      );

  static OutlinedButton outlineGetButton({
    required BuildContext context,
    required Widget? child,
    required void Function()? onPressed,
    double? width,
    double? height,
    Color? color,
    double? radius,
    bool loading = false,
  }) =>
      OutlinedButton(
          style: OutlinedButton.styleFrom(
              elevation: 0,
              side: BorderSide(
                  width: 2, color: Theme.of(context).colorScheme.outline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius?.r ?? 20.0.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              backgroundColor: color ?? Colors.transparent,
              // Theme.of(context).colorScheme.primaryContainer,
              minimumSize:
                  Size(width?.w ?? double.infinity.w, height?.h ?? 50.0.h)),
          onPressed: loading == true ? null : onPressed,
          child: loading
              ? CircularProgressIndicator.adaptive(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                )
              : child);
}
