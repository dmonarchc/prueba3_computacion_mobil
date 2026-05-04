import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  int getFakeStock(int productId) {
    return 10 + (productId % 5);
  }

  void buy(BuildContext context, CartProvider cartProvider) {
    final productsWithoutStock = cartProvider.cart.where((product) {
      return getFakeStock(product.productId) <= 0;
    }).toList();

    if (productsWithoutStock.isNotEmpty) {
      for (final product in productsWithoutStock) {
        cartProvider.removeProduct(product);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Algunos productos no tienen stock y fueron eliminados del carrito',
          ),
        ),
      );

      return;
    }

    cartProvider.clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Compra realizada. Correo enviado al cliente.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Carro de compras')),
      body: cartProvider.cart.isEmpty
          ? const Center(child: Text('El carrito está vacío'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cart.length,
                    itemBuilder: (context, index) {
                      final product = cartProvider.cart[index];

                      return ListTile(
                        leading: Image.network(
                          product.productImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                        ),
                        title: Text(product.productName),
                        subtitle: Text(
                          'Precio: \$${product.productPrice} | Stock: ${getFakeStock(product.productId)}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cartProvider.removeProduct(product);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Total: \$${cartProvider.total}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => buy(context, cartProvider),
                          child: const Text('Comprar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
