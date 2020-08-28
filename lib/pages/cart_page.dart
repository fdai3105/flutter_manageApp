// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_keys.dart';
import '../widgets/button_default.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
    final theme = Theme.of(context);
    return BlocBuilder<CartsBloc, CartsState>(
      builder: (context, state) {
        if (state is CartsLoadSuccess) {
          if (state.carts.isNotEmpty) {
            final _carts = state.carts;
            var total = 0;
            _carts.forEach((element) {
              final totalItem = element.product.price * element.quality;
              total += totalItem;
            });
            return SlidingUpPanel(
//              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              backdropEnabled: true,
              backdropOpacity: 0,
              backdropTapClosesPanel: true,
              minHeight: 80,
              color: Colors.brown,
              body: ListView.builder(
                padding: const EdgeInsets.only(bottom: 180),
                physics: const BouncingScrollPhysics(),
                itemCount: _carts.length,
                itemBuilder: (context, index) {
                  return CartItemList(
                    cart: _carts[index],
                  );
                },
              ),
              panel: Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Total: ${formatMoney(total)}",
                      style: theme.textTheme.bodyText2.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Total item: ${_carts.length}",
                      style: theme.textTheme.bodyText2.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ButtonDefault(
                          onTap: () {},
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                              color: AppKeys.kRedButton,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          text: Text(
                            "Check out!",
                            style: theme.textTheme.bodyText2.copyWith(
                                fontSize: 22, fontWeight: FontWeight.w700),
                          )),
                    )
                  ],
                ),
              ),
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
              "Product : ${_carts.product.name}",
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Price : ${formatMoney(_carts.product.price)}, Qty: ${_carts.quality}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Total : ${formatMoney(_carts.product.price * _carts.quality)}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            trailing: ButtonTheme(
              minWidth: 60,
              height: 50,
              child: FlatButton(
                onPressed: () {
                  context.bloc<CartsBloc>().add(CartDelete(_carts.product));
                },
                color: AppKeys.kRedButton,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ImageIcon(
                  const AssetImage("assets/images/icons/ic_delete.png"),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
