import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTest {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  final String _kNotificationsPrefs = "allowNotifications";
  final String _kSortingOrderPrefs = "sortOrder";
  final String _name = "name";

  /// ------------------------------------------------------------
  /// Method that returns the user decision to allow notifications
  /// ------------------------------------------------------------
  Future<bool> getAllowsNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_kNotificationsPrefs) ?? false;
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision to allow notifications
  /// ----------------------------------------------------------
  Future<bool> setAllowsNotifications(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_kNotificationsPrefs, value);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user decision on sorting order
  /// ------------------------------------------------------------
  Future<String> getSortingOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_kSortingOrderPrefs) ?? 'name';
  }

  /// ----------------------------------------------------------
  /// Method that saves the user decision on sorting order
  /// ----------------------------------------------------------
  Future<bool> setSortingOrder(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_kSortingOrderPrefs, value);
  }

  Future<bool> setName(String value)  {
    final SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;

    return prefs.setString(_name, value);
  }

  String getName()  {
    final SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;

    return prefs.getString(_name) ?? 'name';
  }

}