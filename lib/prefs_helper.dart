import 'package:macros_practice/macros/prefs_macro.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// a macro that generates a relevant constructor and
/// get / set methods for each field in the class
@SharedPreferencesMacro()
class SharedPreferencesHelper {
  /// declare fields with initial values, and THAT'S IT!
  final bool _tutorialShown = false;
  final String _savedDraft = '';
  final int _launchCount = 0;
}

/// Usage example
Future<void> usageExample() async {
  final prefs = await SharedPreferences.getInstance();
  final helper = SharedPreferencesHelper(prefs);

  // Get value
  final hasTutorialShown = helper.getTutorialShown();
  final draft = helper.getSavedDraft();
  final launchCount = helper.getLaunchCount();

  // Set value
  await helper.setTutorialShown(true);
  await helper.setSavedDraft('Introduction to Macros');
  await helper.setLaunchCount(launchCount + 1);
}
