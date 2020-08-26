// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage
class Setting {
  final bool darkMode;

  Setting({this.darkMode});

  @override
  String toString() {
    return 'Setting{darkMode: $darkMode}';
  }

  Setting copyWith({bool darkMode}) {
    return Setting(darkMode: darkMode ?? this.darkMode);
  }
}
