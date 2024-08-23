import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopyee/config/theme/theme.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  Future<void> getDarkModeSetting() async {
    bool isDarkMode =
        await Hive.box('isDarkMode').get('key', defaultValue: false);
    debugPrint('IS DARKMODE : $isDarkMode');

    // Update _themeData based on isDarkMode
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
  }

  // Future<void> initializeTheme() async {
  //   await getDarkModeSetting();
  // }

  void saveDarkModeSetting(bool isDarkMode) async {
    await Hive.box('isDarkMode').clear();
    await Hive.box('isDarkMode').put('key', isDarkMode);
    // Update _themeData and notify listeners
    _themeData = isDarkMode ? darkMode : lightMode;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      saveDarkModeSetting(true);
    } else {
      themeData = lightMode;
      saveDarkModeSetting(false);
    }
  }
}
