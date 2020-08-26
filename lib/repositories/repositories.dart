import 'dart:math';
import '../model/models.dart';

class Repositories {
  List<Cart> carts = [];

  List<Product> products = List<Product>.generate(24, (index) {
    final random = Random().nextInt(categories.length);
    return Product(
        id: index,
        name: "name $index ${categories[random].name}",
        category: categories[random],
        desc: "desc $index",
        price: random * 1000);
  }).toList();

  static List<Category> categories = [
    const Category(id: 0, name: "Clothes"),
    const Category(id: 1, name: "Shoes"),
    const Category(id: 2, name: "Hats"),
    const Category(id: 3, name: "Glasses"),
    const Category(id: 4, name: "Jewels"),
    const Category(id: 5, name: "Underwear"),
    const Category(id: 6, name: "Ect"),
  ];
}
