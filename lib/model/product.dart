// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

import 'package:equatable/equatable.dart';
import 'models.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final Category category;
  final int price;
  final String desc;

  const Product({this.id, this.name, this.category, this.price, this.desc});

  Product copyWith(
      {int id, String name, Category category, int price, String desc}) {
    return Product(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        price: price ?? this.price,
        desc: desc ?? this.desc);
  }

  @override
  String toString() {
    return 'Product {id: $id, name: $name, category: $category, price: $price, desc: $desc}';
  }

  @override
  List<Object> get props => [id, name, category, price, desc];
}
