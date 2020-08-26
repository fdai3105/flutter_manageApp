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

  const TextFieldDialog(
      {Key key, @required this.label, this.defaultValue, @required this.onSave})
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
      onSaved: widget.onSave,
    );
  }
}
