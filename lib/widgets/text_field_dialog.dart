// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

part of 'widgets.dart';

class TextFieldDialog extends StatefulWidget {
  final String label;
  final String defaultValue;
  final onTextFieldSave onSave;
  final bool isPrice;

  const TextFieldDialog(
      {Key key,
      @required this.label,
      this.defaultValue,
      @required this.onSave,
      this.isPrice = false})
      : super(key: key);

  @override
  _TextFieldDialogState createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  TextEditingController _editingController;

  @override
  void initState() {
    if (widget.defaultValue != null) {
      _editingController = TextEditingController(text: widget.defaultValue);
    }
    if (widget.isPrice) {
      _editingController = MoneyMaskedTextController(
          decimalSeparator: "",
          thousandSeparator: ",",
          rightSymbol: " ₫",
          precision: 0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: _editingController,
      decoration: InputDecoration(
        labelText: widget.label ?? "Label",
        labelStyle: theme.inputDecorationTheme.labelStyle,
        border: theme.inputDecorationTheme.border,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
      ),
      onSaved: (value) {
        widget.onSave(widget.isPrice ? replaceMoney(value) : value);
      },
    );
  }
}
