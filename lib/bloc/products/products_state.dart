part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsLoadProgress extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoadSuccess extends ProductsState {
  final List<Product> products;

  const ProductsLoadSuccess({this.products});

  @override
  List<Object> get props => [products];
}

class ProductsLoadFailure extends ProductsState {
  @override
  List<Object> get props => [];
}
