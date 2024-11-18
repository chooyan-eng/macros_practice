import 'package:macros_practice/macros/prefs_macro.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// a macro that generates a relevant constructor and
/// get / set methods for each field in the class
class SharedPreferencesHelper {
  /// declare fields with initial values, and THAT'S IT!
  final bool _tutorialShown = false;
  final String _savedDraft = '';
  final int _launchCount = 0;
}
