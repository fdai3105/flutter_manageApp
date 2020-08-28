// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

part of 'utils.dart';

String formatMoney(int value) {
  if (value != null) {
    final money = NumberFormat().format(value);
    return "$money ₫";
  } else {
    return "";
  }
}

int replaceMoney(String value) {
  final newValue = int.parse(value.replaceAll(RegExp(r'[^\d]'), ""));
  return newValue;
}
