part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsLoadProgress extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoadSuccess extends ProductsState {
  final List<Product> todos;

  const ProductsLoadSuccess({this.todos = const []});

  @override
  List<Object> get props => [todos];
}

class ProductsLoadFailure extends ProductsState {
  @override
  List<Object> get props => [];
}
