// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

part of 'utils.dart';

String formatMoney(int value) {
  if (value != null) {
    final money = NumberFormat().format(value);
    return "$money₫";
  } else {
    return "";
  }
}
