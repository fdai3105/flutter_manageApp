part of 'products_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductLoader extends ProductEvent {
  @override
  List<Object> get props => [];
}

class ProductAdded extends ProductEvent {
  final Product product;

  const ProductAdded({this.product});

  @override
  List<Object> get props => [product];
}

class ProductAddToCart extends ProductEvent {
  final Product product;

  const ProductAddToCart(this.product);

  @override
  List<Object> get props => [product];
}

class ProductUpdated extends ProductEvent {
  final Product product;

  const ProductUpdated({this.product});

  @override
  List<Object> get props => [product];
}

class ProductDeleted extends ProductEvent {
  final Product product;

  const ProductDeleted({this.product});

  @override
  List<Object> get props => [product];
}

class ProductFiltered extends ProductEvent {
  final Category category;

  const ProductFiltered({this.category});

  @override
  List<Object> get props => [category];
}

class ProductSearched extends ProductEvent {
  final String keyWord;

  const ProductSearched({this.keyWord});

  @override
  List<Object> get props => [keyWord];
}
