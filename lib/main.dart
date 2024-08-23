import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopyee/config/theme/theme_provider.dart';
import 'package:shopyee/l10n/l10n.dart';
import 'package:shopyee/language/language_constants.dart';
import 'package:shopyee/login_status.dart';
import 'package:shopyee/model/user/user.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

final box = Provider<List<User>>((ref) => []);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('isDarkMode');
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(UserDetailsAdapter());
  final userData = await Hive.openBox<User>('userBox');

  // Hive.box<User>('userBox').clear();

  for (var i = 0; i < userData.length; i++) {
    final user = userData.getAt(i);
    print('USER : ${user!.userDetails.email}');
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // statusBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ProviderScope(overrides: [
    box.overrideWithValue(userData.values.toList()),
  ], child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends ConsumerState<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocale().then((value) => setLocale(value));
  }

  @override
  void initState() {
    super.initState();
    ref.read(themeProvider.notifier).getDarkModeSetting();
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      builder: (context, child) {
        return MaterialApp(
          //------localization------
          supportedLocales: L10n.all,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: _locale,
          //-------------------
          debugShowCheckedModeBanner: false,
          theme: themeDataProvider.themeData,
          home: const LoginStatus(),
        );
      },
    );
  }
}
