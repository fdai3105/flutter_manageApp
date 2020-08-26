import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/products/products_bloc.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'package:vibration/vibration.dart';
import '../model/models.dart';
import '../bloc/carts/carts_bloc.dart';
import '../bloc/categories/categories_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          BlocBuilder<CartsBloc, CartsState>(
            builder: (context, state) {
              if (state is CartsLoadSuccess) {
                if (state.carts.isNotEmpty) {
                  return Badge(
                    position: BadgePosition.topRight(top: 0, right: 2),
                    badgeColor: Colors.redAccent,
                    badgeContent: Text(
                      "${state.carts.length}",
                      style: TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () => Navigator.pushNamed(context, "/cart"),
                    ),
                  );
                } else {
                  return IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () => Navigator.pushNamed(context, "/cart"),
                  );
                }
              } else {
                return const Text("");
              }
            },
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).iconTheme.color,
            ),
            color: Theme.of(context).backgroundColor,
            onSelected: (value) {
              switch (value) {
                case 1:
                  {
                    Navigator.pushNamed(context, "/setting");
                    break;
                  }
                case 2:
                  {
                    break;
                  }
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Setting"),
                      Icon(Icons.settings)
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text("Info"),
                        Icon(Icons.info)
                      ])),
            ],
          ),
        ],
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: const <Widget>[
            ListCategory(),
            SizedBox(
              height: 20,
            ),
            Search(),
            SizedBox(
              height: 20,
            ),
            ProductList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return DialogAddProduct(
                  title: const Text("Add product"),
                  onTap: (name, category, price, desc) {
                    context.bloc<ProductsBloc>().add(ProductAdded(
                        product: Product(
                            name: name,
                            category: category,
                            price: price,
                            desc: desc)));
                  },
                );
              });
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: IconTheme(
            data: Theme.of(context).iconTheme, child: Icon(Icons.add)),
      ),
    );
  }
}

/// Search box
class Search extends StatelessWidget {
  const Search({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _controller = TextEditingController();
    return TextFormField(
      controller: _controller,
      onChanged: (value) {
        context.bloc<ProductsBloc>().add(ProductSearched(keyWord: value));
      },
      autofocus: false,
      decoration: InputDecoration(
          hintText: "Search: ",
          suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: theme.iconTheme.color,
              ),
              onPressed: () {
                _controller.clear();
                context
                    .bloc<ProductsBloc>()
                    .add(const ProductSearched(keyWord: ""));
              })),
    );
  }
}

/// list category
class ListCategory extends StatelessWidget {
  const ListCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesSuccess) {
            final categories = state.categories;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (builder, index) {
                  return _CategoryButton(
                    category: categories[index],
                    isSelect: state.selectID == categories[index].id,
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;
  final bool isSelect;

  const _CategoryButton({Key key, this.category, this.isSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return GestureDetector(
      onTap: () {
        context.bloc<CategoriesBloc>().add(CategorySelect(
              category: isSelect ? null : category,
              selectID: isSelect ? null : category.id,
            ));
        context
            .bloc<ProductsBloc>()
            .add(ProductFiltered(category: isSelect ? null : category));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelect ? theme.cardColor : Colors.transparent),
        child: Row(
          children: <Widget>[
            Text(
              category.name,
              style: textTheme.bodyText1,
            ),
            const SizedBox(
              width: 10,
            ),
            if (isSelect)
              Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close,
                    size: 20,
                  )),
          ],
        ),
      ),
    );
  }
}

/// List item
class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadSuccess) {
            if (state.todos.isNotEmpty) {
              final _todos = state.todos;
              return ProductItem(todos: _todos, theme: theme);
            } else {
              return const Center(
                child: Text("Nothing to show"),
              );
            }
          } else if (state is ProductsLoadProgress) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('text'));
          }
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    @required List<Product> todos,
    @required this.theme,
  })  : _todos = todos,
        super(key: key);

  final List<Product> _todos;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _todos.length,
        itemBuilder: (builder, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: (index == 0) ? 0 : 20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    elevation: 18,
                    builder: (context) => BottomSheetTodo(
                          product: _todos[index],
                        ));
              },
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              leading: CachedNetworkImage(
                placeholder: (context, value) {
                  return const CircularProgressIndicator();
                },
                imageUrl: "https://via.placeholder.com/220x220?text=fdai",
              ),
              title: Text(
                "${_todos[index].name}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Cate: ${_todos[index].category.name}",
                    style: theme.textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Price: ${formatMoney(_todos[index].price)}",
                    style: theme.textTheme.bodyText2,
                  ),
                ],
              ),
              trailing: _AddToCartButton(todo: _todos[index]),
            ),
          );
        });
  }
}

class _AddToCartButton extends StatelessWidget {
  final Product todo;

  const _AddToCartButton({
    Key key,
    this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartsBloc, CartsState>(
      builder: (context, state) {
        if (state is CartsLoadSuccess) {
          final todos = state.carts.map((e) => e.todo).toList();
          return FlatButton(
            onPressed: () {
              Vibration.vibrate(duration: 100);
              todos.contains(todo)
                  ? context.bloc<CartsBloc>().add(CartDelete(todo))
                  : context.bloc<CartsBloc>().add(CartAdd(todo));
            },
            color: Theme.of(context).buttonColor,
            splashColor: Colors.white24,
            child: todos.contains(todo)
                ? Text(
                    "Remove",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.greenAccent),
                  )
                : Text(
                    "Add",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
          );
        } else if (state is CartsLoadProgress) {
          return const CircularProgressIndicator();
        } else if (state is CartsLoadFailure) {
          return const Text("error");
        } else {
          return const Text("data");
        }
      },
    );
  }
}
