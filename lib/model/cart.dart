// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

import 'package:equatable/equatable.dart';

import 'product.dart';

class Cart extends Equatable {
  final int id;
  final Product todo;
  final int quality;

  const Cart({this.id, this.todo, this.quality});

  @override
  String toString() {
    return 'Cart{id: $id, todo: $todo, quality: $quality} \n';
  }

  Cart copyWith({int id, Product todo, int quality}) {
    return Cart(id: id ?? this.id,
        todo: todo ?? this.todo,
        quality: quality ?? this.quality);
  }

  @override
  List<Object> get props => [id,todo,quality];
}
