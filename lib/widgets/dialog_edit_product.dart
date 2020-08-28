// @author Hoàng Phi Đại
// @version 0.1
// @desc Hue city, Vietnam
// @link ff3105.github.io
// @created  $
// @Usage

part of 'widgets.dart';

class DialogEditProduct extends StatelessWidget {
  final Text title;
  final onSaveTap onTap;
  final Product product;

  const DialogEditProduct({
    Key key,
    @required this.title,
    @required this.product,
    @required this.onTap,
  }) : super(key: key);

  /// [kContentW] = two button width size + space width (should be 20)
  static const double kRadius = 20;
  static const double kContentW = 240 + 20.0;
  static const double kSizedBoxH = 15;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _kForm = GlobalKey<FormState>();
    String name;
    Category category;
    int price;
    String desc;

    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaY: AppKeys.kBlurDefault, sigmaX: AppKeys.kBlurDefault),
      child: AlertDialog(
        title: title ?? const Text("title"),
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
                              defaultValue: product.name.toString(),
                              onSave: (value) => name = value,
                            ),
                            const SizedBox(
                              height: kSizedBoxH,
                            ),
                            DropDownDialog(
                              items: Repositories.categories,
                              category: product.category,
                              onChange: (value) => category = value,
                            ),
                            const SizedBox(
                              height: kSizedBoxH,
                            ),
                            TextFieldDialog(
                              label: "Desc product",
                              defaultValue: product.desc,
                              onSave: (value) => desc = value,
                            ),
                            const SizedBox(
                              height: kSizedBoxH,
                            ),
                            TextFieldDialog(
                                label: "Price",
                                defaultValue: product.price.toString(),
                                isPrice: true,
                                onSave: (value) => price = value),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: kSizedBoxH,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonDefault(
                        onTap: () {
                          _kForm.currentState.save();
                          onTap(name, category, price, desc);
                          Navigator.popUntil(context, ModalRoute.withName("/"));
                        },
                        text: Text(
                          "OK",
                          style: theme.textTheme.button,
                        ),
                      ),
                      ButtonDefault(
                          onTap: () => Navigator.pop(context),
                          text: Text(
                            "Cancel",
                            style: theme.textTheme.button,
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
