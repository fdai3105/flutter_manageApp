import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/repositories.dart';
import '../../model/models.dart';

part 'categories_state.dart';
part 'categories_event.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is CategoriesLoader) {
      yield* _mapCategoriesLoaderToState();
    } else if (event is CategorySelect) {
      yield* _mapCategoriesSelectedToState(event);
    }
  }

  Stream<CategoriesState> _mapCategoriesLoaderToState() async* {
    yield CategoriesSuccess(categories: Repositories.categories);
  }

  Stream<CategoriesState> _mapCategoriesSelectedToState(
      CategorySelect event) async* {
    final currentCategories = (state as CategoriesSuccess).categories;
    yield CategoriesSuccess(
        categories: currentCategories, selectID: event.selectID);
  }
}
