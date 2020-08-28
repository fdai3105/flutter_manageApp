import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/models.dart';
import '../../model/product.dart';
import '../../repositories/repositories.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductEvent, ProductsState> {
  final Repositories _repositories;
  ProductFiltered _productFiltered;
  ProductSearched _productSearched;

  ProductsBloc(this._repositories) : super(ProductsLoadProgress());

  @override
  Stream<ProductsState> mapEventToState(ProductEvent event) async* {
    if (event is ProductLoader) {
      yield* _mapProductsLoadedToState();
    } else if (event is ProductAdded) {
      yield* _mapProductAddedToState(event);
    } else if (event is ProductUpdated) {
      yield* _mapProductUpdateToState(event);
    } else if (event is ProductDeleted) {
      yield* _mapProductDeleteToState(event);
    } else if (event is ProductFiltered) {
      _productFiltered = event;
      yield* _mapProductFilteredToState(
        filtered: event,
        searched: null,
      );
    } else if (event is ProductSearched) {
      _productSearched = event;
      yield* _mapProductSearchedToState(event);
    }
  }

  Stream<ProductsState> _mapProductsLoadedToState() async* {
    yield ProductsLoadSuccess(products: _repositories.products);
  }

  Stream<ProductsState> _mapProductAddedToState(ProductAdded event) async* {
    _repositories.products.add(event.product
        .copyWith(id: event.product.id ?? _repositories.products.length));
    yield* _mapProductSearchedToState(_productSearched);
  }

  Stream<ProductsState> _mapProductUpdateToState(ProductUpdated event) async* {
    final products = _repositories.products;
    for (var i = 0; i < products.length; i++) {
      if (products[i].id == event.product.id) {
        products[i] = event.product;
      }
    }
    yield* _mapProductSearchedToState(_productSearched);
  }

  Stream<ProductsState> _mapProductDeleteToState(ProductDeleted event) async* {
    _repositories.products
        .removeWhere((element) => element.id == event.product.id);
    yield* _mapProductSearchedToState(_productSearched);
  }

  Stream<ProductsState> _mapProductSearchedToState(
      ProductSearched event) async* {
    yield ProductsLoadProgress();
    yield* _mapProductFilteredToState(
        filtered: _productFiltered, searched: _productSearched);
  }

  Stream<ProductsState> _mapProductFilteredToState(
      {ProductFiltered filtered, ProductSearched searched}) async* {
    filtered ??= _productFiltered;
    searched ??= _productSearched;
    final _filterProducts = _repositories.products.where((element) {
      if (filtered == null || filtered.category == null) {
        if (searched == null) {
          return true;
        } else {
          return element.name.toLowerCase().contains(searched.keyWord);
        }
      } else {
        if (searched == null || searched.keyWord == null) {
          return element.category.id == filtered.category.id;
        } else {
          return element.category.id == filtered.category.id &&
              element.name.toLowerCase().contains(searched.keyWord);
        }
      }
    }).toList();
    yield ProductsLoadSuccess(products: _filterProducts);
  }
}
