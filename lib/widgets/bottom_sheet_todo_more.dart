// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

part of 'widgets.dart';

class BottomSheetTodo extends StatelessWidget {
  final Product product;

  const BottomSheetTodo({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // edit todos
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (builder) {
                return DialogEditProduct(
                  title: const Text("Edit product"),
                  product: product,
                  onTap: (name, category, price, desc) {
                    context.bloc<ProductsBloc>().add(
                          ProductUpdated(
                            product: product.copyWith(
                                name: name,
                                category: category,
                                price: price,
                                desc: desc),
                          ),
                        );
                  },
                );
              },
            );
          },
          child: ListTile(
            title: Text(
              "Edit todo",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: Icon(Icons.edit),
          ),
        ),
        // delete todos
        InkWell(
          onTap: () {
            context.bloc<ProductsBloc>().add(ProductDeleted(product: product));
            Navigator.pop(context);
          },
          child: ListTile(
            title: Text(
              "Delete todo",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: Icon(Icons.delete),
          ),
        ),
      ],
    );
  }
}
