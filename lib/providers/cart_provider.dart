import 'package:flutter/material.dart';
import '../models/productos.dart';

class CartItem {
  final Listado product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> cart = [];
  final Map<int, int> stockLocal = {};

  int getStock(Listado product) {
    stockLocal.putIfAbsent(
      product.productId,
      () => 5 + (product.productId % 6),
    );

    return stockLocal[product.productId]!;
  }

  void addProduct(Listado product) {
    final index = cart.indexWhere(
      (item) => item.product.productId == product.productId,
    );

    if (index >= 0) {
      cart[index].quantity++;
    } else {
      cart.add(CartItem(product: product));
    }

    notifyListeners();
  }

  void increaseQuantity(Listado product) {
    final index = cart.indexWhere(
      (item) => item.product.productId == product.productId,
    );

    if (index >= 0) {
      cart[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(Listado product) {
    final index = cart.indexWhere(
      (item) => item.product.productId == product.productId,
    );

    if (index >= 0) {
      if (cart[index].quantity > 1) {
        cart[index].quantity--;
      } else {
        cart.removeAt(index);
      }

      notifyListeners();
    }
  }

  void removeProduct(Listado product) {
    cart.removeWhere((item) => item.product.productId == product.productId);

    notifyListeners();
  }

  List<CartItem> getProductsWithoutStock() {
    return cart.where((item) {
      final availableStock = getStock(item.product);
      return item.quantity > availableStock;
    }).toList();
  }

  void removeProductsWithoutStock() {
    final productsWithoutStock = getProductsWithoutStock();

    for (final item in productsWithoutStock) {
      removeProduct(item.product);
    }

    notifyListeners();
  }

  void buyProducts() {
    for (final item in cart) {
      final currentStock = getStock(item.product);
      stockLocal[item.product.productId] = currentStock - item.quantity;
    }

    cart.clear();
    notifyListeners();
  }

  int get total {
    return cart.fold(
      0,
      (sum, item) => sum + (item.product.productPrice * item.quantity),
    );
  }

  int get totalItems {
    return cart.fold(0, (sum, item) => sum + item.quantity);
  }
}
