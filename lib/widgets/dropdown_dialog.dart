// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

part of 'widgets.dart';

/// Dropdown category
class DropDownDialog extends StatefulWidget {
  final List<Category> items;
  final onSelectCategory onChange;
  final Category category;

  const DropDownDialog(
      {Key key,
      @required this.items,
      @required this.onChange,
      @required this.category})
      : super(key: key);

  @override
  _DropDownDialogState createState() => _DropDownDialogState();
}

class _DropDownDialogState extends State<DropDownDialog> {
  Category _selectCategory;

  @override
  void initState() {
    setState(() {
      _selectCategory = widget.category;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white30, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              onTap: () {
                unFocusTextField(context);
              },
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              hint: const Text("Select category"),
              isExpanded: true,
              value: _selectCategory,
              items: widget.items
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item.name)))
                  .toList(),
              onChanged: (value) {
                widget.onChange(value);
                setState(() {
                  _selectCategory = value;
                });
              }),
        ),
      ),
    );
  }
}
