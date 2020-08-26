part of 'carts_bloc.dart';

abstract class CartsState extends Equatable {
  const CartsState();
}

class CartsLoadProgress extends CartsState {
  @override
  List<Object> get props => [];
}

class CartsLoadSuccess extends CartsState {
  final List<Cart> carts;

  const CartsLoadSuccess({this.carts = const []});

  @override
  List<Object> get props => [carts];

  @override
  String toString() {
    return 'CartsLoadSuccess{carts: $carts}';
  }
}

class CartsEditSuccess extends CartsState {
  final Cart cart;

  const CartsEditSuccess(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartsLoadFailure extends CartsState {
  @override
  List<Object> get props => [];
}
