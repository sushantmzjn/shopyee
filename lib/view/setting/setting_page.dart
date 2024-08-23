import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopyee/config/theme/theme_provider.dart';
import 'package:shopyee/config/widgets/custom_switch.dart';
import 'package:shopyee/language/language.dart';
import 'package:shopyee/language/language_constants.dart';
import 'package:shopyee/main.dart';
import 'package:shopyee/view/setting/widgets/setting_menu.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  @override
  void initState() {
    super.initState();
    getLng();
  }

  String? selectedLanguage;
  void getLng() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode') ?? 'English';
    // print(languageCode);
    setState(() {
      if (languageCode == 'ne') {
        selectedLanguage = '🇳🇵';
      } else {
        selectedLanguage = '🇺🇸';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).setting),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: const CustomSwitch(),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Theme.of(context).colorScheme.secondary,
          ),

          //---------language change
          SettingMenu(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12.r))),
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 250.h,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            height: 4.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(translation(context).chooseLanguage,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(height: 8.h),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: Language.languageList().length,
                                    itemBuilder: (context, index) {
                                      Language language =
                                          Language.languageList()[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            selectedLanguage = language.flag;
                                            Locale _locale = await setLocale(
                                                language.languageCode);
                                            // ignore: use_build_context_synchronously
                                            MyApp.setLocale(context, _locale);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                              height: 30.h,
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0,
                                                      horizontal: 6.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 1,
                                                        offset:
                                                            const Offset(1, 2)),
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 1,
                                                        offset: const Offset(
                                                            -1, -2)),
                                                  ]),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(Language.languageList()[
                                                          index]
                                                      .flag),
                                                  const VerticalDivider(
                                                    color: Colors.grey,
                                                  ),
                                                  Text(
                                                    Language.languageList()[
                                                            index]
                                                        .name,
                                                    style: TextStyle(
                                                        color: themeDataProvider
                                                                .isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const Spacer(),
                                                  selectedLanguage ==
                                                          Language.languageList()[
                                                                  index]
                                                              .flag
                                                      ? Image.asset(
                                                          'assets/accept.png',
                                                          color: Colors.blue,
                                                          height: 10.h,
                                                        )
                                                      : Container()
                                                ],
                                              )),
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            text: translation(context).changeLanguage,
          ),
          //-----------------language change end----------------------
          Divider(
            height: 0,
            thickness: 0.5,
            color: Theme.of(context).colorScheme.secondary,
          ),
          SettingMenu(
            onTap: () {},
            text: 'About',
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
