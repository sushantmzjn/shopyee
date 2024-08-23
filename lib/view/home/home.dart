import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopyee/config/theme/theme_provider.dart';
import 'package:shopyee/provider/auth_provider/auth_provider.dart';
import 'package:shopyee/view/sidebar_menu/side_menu.dart';

class Home extends ConsumerWidget {
  Home({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(userLoginProvider);
    final deviceTheme = ref.watch(themeProvider);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.secondary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.sort,
                            size: 26.r,
                          ),
                        )),
                    // const CircleAvatar(
                    //   backgroundColor: Colors.white,
                    //   radius: 20,
                    //   child: Icon(Icons.person, color: Colors.black),
                    // ),
                  ],
                ),
              ),
              Text(auth.user[0].userDetails.email),
            ],
          ),
        ),
      ),
    );
  }
}
