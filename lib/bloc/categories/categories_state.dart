part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesProgress extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesSuccess extends CategoriesState {
  final List<Category> categories;
  final int selectID;

  const CategoriesSuccess({this.categories, this.selectID});

  @override
  List<Object> get props => [categories, selectID];

  CategoriesSuccess copyWith({List<Category> categories, int selectID}) {
    return CategoriesSuccess(
        categories: categories ?? this.categories,
        selectID: selectID ?? this.selectID);
  }
}

class CategoriesFailure extends CategoriesState {
  @override
  List<Object> get props => [];
}

