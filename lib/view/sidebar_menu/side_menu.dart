import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopyee/config/widgets/navigation.dart';
import 'package:shopyee/language/language_constants.dart';
import 'package:shopyee/provider/auth_provider/auth_provider.dart';
import 'package:shopyee/view/profile/profile.dart';
import 'package:shopyee/view/setting/setting_page.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(userLoginProvider);

    return Container(
      width: MediaQuery.of(context).size.width / 1.6,
      height: double.infinity,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top),
          Container(
            height: 80.h,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'SHOPYEE',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Theme.of(context).colorScheme.secondary,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              navigatePush(context, const Profile());
            },
            child: ListTile(
              title: Text(
                translation(context).profile,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Theme.of(context).colorScheme.secondary,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              navigatePush(context, const SettingPage());
            },
            child: ListTile(
              title: Text(
                translation(context).setting,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Theme.of(context).colorScheme.secondary,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              ref.read(userLoginProvider.notifier).userLogOut();
            },
            child: ListTile(
              title: Text(
                translation(context).logout,
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
