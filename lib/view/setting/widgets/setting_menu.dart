import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingMenu extends StatelessWidget {
  String text;
  void Function()? onTap;
  IconData? icon;
  SettingMenu({super.key, required this.text, required this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(child: Text(text)),
            Padding(
              padding: EdgeInsets.only(right: 10.r),
              child: Icon(
                icon ?? Icons.arrow_forward_ios,
                size: 16.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
