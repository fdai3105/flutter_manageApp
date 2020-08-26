// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/utils.dart';
import '../bloc/carts/carts_bloc.dart';
import '../model/cart.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: const CartListView(),
      ),
    );
  }
}

class CartListView extends StatelessWidget {
  const CartListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartsBloc, CartsState>(
      builder: (context, state) {
        if (state is CartsLoadSuccess) {
          if (state.carts.isNotEmpty) {
            final _carts = state.carts;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _carts.length,
              itemBuilder: (context, index) {
                return CartItemList(
                  cart: _carts[index],
                );
              },
            );
          } else {
            return const Center(
              child: Text("Nothing to show"),
            );
          }
        } else if (state is CartsLoadProgress) {
          return const CircularProgressIndicator();
        } else if (state is CartsLoadFailure) {
          return const Center(child: Text("Fail"));
        } else {
          return const Text(":(((");
        }
      },
    );
  }
}

class CartItemList extends StatelessWidget {
  const CartItemList({
    @required Cart cart,
    Key key,
  })  : _carts = cart,
        super(key: key);

  final Cart _carts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CartsBloc, CartsState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            onTap: () {
              context.bloc<CartsBloc>().add(
                  CartIncrement(_carts.copyWith(quality: _carts.quality + 1)));
            },
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            title: Text(
              "Product : ${_carts.todo.name}",
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Price : ${formatMoney(_carts.todo.price)}, Qty: ${_carts.quality}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Total : ${formatMoney(_carts.todo.price * _carts.quality)}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            trailing: ButtonTheme(
              minWidth: 16,
              child: FlatButton(
                color: Colors.blueGrey,
                onPressed: () {
                  context.bloc<CartsBloc>().add(CartDelete(_carts.todo));
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
