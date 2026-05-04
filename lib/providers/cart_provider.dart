import 'package:flutter/material.dart';
import '../models/productos.dart';

class CartProvider extends ChangeNotifier {
  final List<Listado> cart = [];

  void addProduct(Listado product) {
    cart.add(product);
    notifyListeners();
  }

  void removeProduct(Listado product) {
    cart.remove(product);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  int get total {
    return cart.fold(0, (sum, item) => sum + item.productPrice);
  }
}
