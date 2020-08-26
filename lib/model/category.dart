// @author Hoàng Phi Đại
// @version
// @link ff3105.github.io
// @created  $
// @Usage
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;

  const Category({this.id, this.name});

  @override
  String toString() {
    return 'Category {id: $id, name: $name}';
  }

  @override
  List<Object> get props => [id, name];
}
