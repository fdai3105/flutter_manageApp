import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/repositories.dart';
import '../../model/models.dart';

part 'carts_event.dart';

part 'carts_state.dart';

class CartsBloc extends Bloc<CartEvent, CartsState> {
  final Repositories _repositories;

  CartsBloc(this._repositories) : super(CartsLoadProgress());

  @override
  Stream<CartsState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartLoader) {
      yield* _mapCartLoaderToState();
    } else if (event is CartAdd) {
      yield* _mapCartAdderToState(event);
    } else if (event is CartDelete) {
      yield* _mapCartDeletedToState(event);
    } else if (event is CartIncrement) {
      yield* _mapCartIncrementToState(event);
    } else if (event is CartDecrement) {
      yield* _mapCartDecrementToState(event);
    }
  }

  Stream<CartsState> _mapCartLoaderToState() async* {
    yield CartsLoadSuccess(carts: _repositories.carts);
  }

  Stream<CartsState> _mapCartAdderToState(CartAdd event) async* {
    final carts = List<Cart>.from((state as CartsLoadSuccess).carts);
    carts.add(Cart(id: carts.length, todo: event.todo, quality: 1));
    yield CartsLoadSuccess(carts: carts);
  }

  Stream<CartsState> _mapCartDeletedToState(CartDelete event) async* {
    final _delCart = List<Cart>.from((state as CartsLoadSuccess).carts)
      ..removeWhere((element) => element.todo.id == event.todo.id);
    yield CartsLoadSuccess(carts: _delCart);
  }

  Stream<CartsState> _mapCartIncrementToState(CartIncrement event) async* {
    final _carts = List<Cart>.from((state as CartsLoadSuccess).carts).map((e) {
      return e.id == event.cart.id ? event.cart : e;
    }).toList();
    yield CartsLoadSuccess(carts: _carts);
  }

  Stream<CartsState> _mapCartDecrementToState(CartDecrement event) async* {
    final _carts = List<Cart>.from((state as CartsLoadSuccess).carts).map((e) {
      return e.id == event.cart.id ? event.cart : e;
    }).toList();
    yield CartsLoadSuccess(carts: _carts);
  }
}
