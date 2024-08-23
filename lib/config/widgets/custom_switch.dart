import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopyee/config/theme/theme_provider.dart';

class CustomSwitch extends ConsumerWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
            title: Text(
              themeData.isDarkMode ? 'Dark Mode' : 'Light Mode',
              style: TextStyle(fontSize: 14.sp),
            ),
            trailing: Transform.scale(
              scale: 0.85,
              child: Switch(
                activeColor: Colors.transparent,
                inactiveThumbColor: const Color.fromRGBO(0, 0, 0, 0),
                activeTrackColor: Colors.white,
                thumbColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.white.withOpacity(.48);
                    }
                    return Colors.white;
                  },
                ),
                activeThumbImage: const AssetImage('assets/dark.png'),
                inactiveThumbImage: const AssetImage('assets/light.png'),
                value: themeData.isDarkMode,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
