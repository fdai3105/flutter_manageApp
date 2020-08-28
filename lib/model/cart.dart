// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage

import 'package:equatable/equatable.dart';

import 'product.dart';

class Cart extends Equatable {
  final int id;
  final Product product;
  final int quality;

  const Cart({this.id, this.product, this.quality});

  Cart copyWith({int id, Product product, int quality}) {
    return Cart(id: id ?? this.id,
        product: product ?? this.product,
        quality: quality ?? this.quality);
  }

  @override
  List<Object> get props => [id,product,quality];
}
