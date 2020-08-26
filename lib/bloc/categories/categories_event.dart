part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class CategoriesLoader extends CategoriesEvent {
  @override
  List<Object> get props => [];
}

class CategorySelect extends CategoriesEvent {
  final Category category;
  final int selectID;

  const CategorySelect({this.category, this.selectID});

  @override
  List<Object> get props => [category];
}