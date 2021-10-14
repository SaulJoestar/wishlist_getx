import 'package:get/get.dart';
import 'dart:math';
import '../models/item.dart';

class Products extends GetxController {
  List<String> games = [
    'Elden Ring',
    'Battlefield 2042',
    'Halo Infinite',
    'Destiny 2 The Witch Queen',
    'Zelda Botw 2',
    'Dying Light 2',
    'God Of War Ragnarok',
    'Horizon Forbidden West',
    'Starfield',
    'Pokemon Arceus'
  ];
  // All products
  // In production, these things usually be loaded them from API or database or something like that
  late RxList<Item> _items;

  Products() {
    _items = List.generate(
        10,
        (index) => Item(
            id: index,
            name: games[index],
            price: 60 + Random().nextDouble() * 10,
            inWishList: false.obs)).obs;
  }
  // Use this to retrieve all products
  List<Item> get items {
    return [..._items];
  }

  // This will return the products that were added to wish list
  List<Item> get wishListItems {
    return _items.where((item) => item.inWishList.value == true).toList();
  }

  // Add an item to the wish list
  void addItem(int id) {
    final int index = _items.indexWhere((item) => item.id == id);
    _items[index].inWishList.value = true;
  }

  // Remove an item from the wish list
  void removeItem(int id) {
    final int index = _items.indexWhere((item) => item.id == id);
    _items[index].inWishList.value = false;
  }
}
