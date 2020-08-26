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
      yield* _mapTodosLoadedToState();
    } else if (event is ProductAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is ProductUpdated) {
      yield* _mapTodoUpdateToState(event);
    } else if (event is ProductDeleted) {
      yield* _mapTodoDeleteToState(event);
    } else if (event is ProductFiltered) {
      _productFiltered = event;
      yield* _mapTodoFilteredToState(
        filtered: event,
        searched: null,
      );
    } else if (event is ProductSearched) {
      _productSearched = event;
      yield* _mapTodoSearchedToState(event);
    }
  }

  Stream<ProductsState> _mapTodosLoadedToState() async* {
    yield ProductsLoadSuccess(todos: _repositories.products);
  }

  Stream<ProductsState> _mapTodoAddedToState(ProductAdded event) async* {
    _repositories.products.add(event.product);
    yield* _mapTodoSearchedToState(_productSearched);
  }

  Stream<ProductsState> _mapTodoUpdateToState(ProductUpdated event) async* {
    final products = _repositories.products;
    for (var i = 0; i < products.length; i++) {
      if (products[i].id == event.product.id) {
        products[i] = event.product;
      }
    }
    yield* _mapTodoSearchedToState(_productSearched);
  }

  Stream<ProductsState> _mapTodoDeleteToState(ProductDeleted event) async* {
    _repositories.products
        .removeWhere((element) => element.id == event.product.id);
    yield* _mapTodoSearchedToState(_productSearched);
  }

  Stream<ProductsState> _mapTodoSearchedToState(ProductSearched event) async* {
    yield* _mapTodoFilteredToState(
        filtered: _productFiltered, searched: _productSearched);
  }

  Stream<ProductsState> _mapTodoFilteredToState(
      {ProductFiltered filtered, ProductSearched searched}) async* {
    filtered ??= _productFiltered;
    searched ??= _productSearched;
    final _filterTodo = _repositories.products.where((element) {
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
    yield ProductsLoadSuccess(todos: _filterTodo);
  }
}
