// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

part of 'utils.dart';

class SharePref {
  SharedPreferences _preferences;

  Future<void> setDarkMode({bool darkMode}) async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences.setBool(AppKeys.kSharePrefDarkMode, darkMode);
  }

  Future<bool> getDarkMode() async {
    _preferences = await SharedPreferences.getInstance();
    final darkMode = _preferences.getBool(AppKeys.kSharePrefDarkMode);
    return darkMode;
  }
}
