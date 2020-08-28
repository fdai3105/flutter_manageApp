part of 'widgets.dart';

class DialogAddProduct extends StatelessWidget {
  final Text title;
  final onSaveTap onTap;

  const DialogAddProduct({Key key, this.title, this.onTap}) : super(key: key);

  /// [kContentW] = two button width size + space width (should be 20)
  static const double kRadius = 20;
  static const double kContentW = 240 + 20.0;
  static const double kSizedBoxH = 15;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _kForm = GlobalKey<FormState>();
    String _name;
    Category _category;
    int _price;
    String _desc;
    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaX: AppKeys.kBlurDefault, sigmaY: AppKeys.kBlurDefault),
      child: AlertDialog(
        title: title ?? const Text("Title"),
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius)),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: kContentW,
                    alignment: AlignmentDirectional.centerStart,
                    child: Form(
                        key: _kForm,
                        child: Column(
                          children: <Widget>[
                            TextFieldDialog(
                              label: "Name product",
                              onSave: (value) => _name = value,
                            ),
                            const SizedBox(
                              height: kSizedBoxH,
                            ),
                            TextFieldDialog(
                                label: "Desc product",
                                onSave: (value) => _desc = value),
                            const SizedBox(
                              height: kSizedBoxH,
                            ),
                            TextFieldDialog(
                              label: "Price product",
                              onSave: (value) => _price = value,
                              isPrice: true,
                            ),
                            const SizedBox(
                              height: kSizedBoxH,
                            ),
                            TextFieldDialog(
                                label: "Desc product",
                                onSave: (value) => _desc = value)
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: kSizedBoxH,
                  ),
                  DropDownDialog(
                      items: Repositories.categories,
                      onChange: (value) => _category = value,
                      category: null),
                  const SizedBox(
                    height: kSizedBoxH,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // Submit button
                      ButtonDefault(
                        onTap: () {
                          _kForm.currentState.save();
                          onTap(_name, _category, _price, _desc);
                          Navigator.pop(context);
                        },
                        text: Text(
                          "OK",
                          style: _theme.textTheme.button,
                        ),
                      ),
                      // Cancel button
                      ButtonDefault(
                          onTap: () => Navigator.pop(context),
                          text: Text(
                            "Cancel",
                            style: _theme.textTheme.button,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10))),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
