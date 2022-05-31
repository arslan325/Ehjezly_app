import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static const name = "name";
  static const email = "email";
  static const profile = "profile";
  static const token = "token";
}

/// Singleton PreferenceManager to handle app local preference on device
/// `SharedPreferences` must be set in order for this manager to work
class PreferenceManager {

  /// Shared object which is used. No new instances are created for this class
  static final PreferenceManager _shared = PreferenceManager._internal();

  /// Factory returns `_shared` object for every
  /// instantiation like `PreferenceManager()`
  factory PreferenceManager() {
    return _shared;
  }

  /// Private constructor
  PreferenceManager._internal();

  /// SharedPreferences instance
  SharedPreferences? _prefs;

  /// Boolean get to check if `_prefs` are initialized
  bool get _isInitialized => _prefs != null;

  // Set prefs
  set prefs(SharedPreferences prefs) => {
    if (_isInitialized) {
      debugPrint("🐞 WARNING: SharedPreferences are already initialized. Should only be initialized once.")
    } else {
      _prefs = prefs
    }
  };

  /// Initializes `SharedPreferences`. This has to be set after
  /// `WidgetsFlutterBinding.ensureInitialized();`. This ensures
  /// that native libraries are loaded. Native library in this
  /// case is `SharedPreferences` instance.
  init() async {
    prefs = await SharedPreferences.getInstance();
  }


  String get getEmail => _prefs?.getString(_Keys.email) ?? "";
  set setEmail(String value) => _prefs?.setString(_Keys.email, value);

  String get getToken => _prefs?.getString(_Keys.token) ?? "";
  set setToken(String value) => _prefs?.setString(_Keys.token, value);

  String get getName => _prefs?.getString(_Keys.name) ?? "";
  set setName(String value) => _prefs?.setString(_Keys.name, value);

  String get getProfile => _prefs?.getString(_Keys.profile) ?? "";
  set setProfile(String value) => _prefs?.setString(_Keys.profile, value);

}
