part of 'carts_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartLoader extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartAdd extends CartEvent {
  final Product product;

  const CartAdd(this.product);

  @override
  List<Object> get props => [product];
}

class CartDelete extends CartEvent {
  final Product product;

  const CartDelete(this.product);

  @override
  List<Object> get props => [product];
}

class CartIncrement extends CartEvent {
  final Cart cart;

  const CartIncrement(this.cart);

  @override
  List<Object> get props => [cart];

  @override
  String toString() {
    return 'CartIncrement {cart: $cart}';
  }
}

class CartDecrement extends CartEvent {
  final Cart cart;

  const CartDecrement(this.cart);

  @override
  List<Object> get props => [cart];

  @override
  String toString() {
    return 'CartDecrement {cart: $cart}';
  }
}
