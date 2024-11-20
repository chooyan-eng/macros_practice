import 'package:flutter/material.dart';
import 'package:macros_practice/macros/prefs_macro.dart';
import 'package:shared_preferences/shared_preferences.dart';

@SharedPreferencesMacro()
class PrefsHelper {
  final bool isFirstLaunch = true;
  final String sessionToken = '';
  final double duration = 1.0;
}

Future<void> sampleUsage() async {
  final prefs = await SharedPreferences.getInstance();
  final prefsHelper = PrefsHelper(prefs);
  prefsHelper.setIsFirstLaunch(false);
  debugPrint(prefsHelper.getIsFirstLaunch().toString());
}
