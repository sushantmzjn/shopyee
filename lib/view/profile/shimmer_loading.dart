import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopyee/config/theme/theme_provider.dart';

class ShimmerLoading extends ConsumerWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final deviceTheme = ref.watch(themeProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 220.h,
                width: double.infinity,
                color: deviceTheme.isDarkMode
                    ? Colors.white24
                    : Colors.black.withOpacity(0.04),
              ),
              Positioned(
                top: 175.h,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 18.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 98,
                        height: 95,
                        decoration: BoxDecoration(
                          color: deviceTheme.isDarkMode
                              ? Colors.white24
                              : Colors.black.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 10.h,
                                width: 120,
                                color: deviceTheme.isDarkMode
                                    ? Colors.white24
                                    : Colors.black.withOpacity(0.04),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                height: 10.h,
                                width: 200.w,
                                color: deviceTheme.isDarkMode
                                    ? Colors.white24
                                    : Colors.black.withOpacity(0.04),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
