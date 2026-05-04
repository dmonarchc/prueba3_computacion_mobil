import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/cart_provider.dart';
import '../services/services.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> sendPurchaseEmail(
    String email,
    CartProvider cartProvider,
  ) async {
    final body = StringBuffer();

    body.writeln('Gracias por su compra.');
    body.writeln('');
    body.writeln('Detalle de compra:');

    for (final item in cartProvider.cart) {
      body.writeln(
        '- ${item.product.productName} x${item.quantity} = \$${item.product.productPrice * item.quantity}',
      );
    }

    body.writeln('');
    body.writeln('Total: \$${cartProvider.total}');

    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Compra realizada', 'body': body.toString()},
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void buy(BuildContext context, CartProvider cartProvider) async {
    final authService = Provider.of<AuthServices>(context, listen: false);
    final email = authService.currentEmail;

    if (email == null || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se encontró el correo del cliente.')),
      );
      return;
    }

    final productsWithoutStock = cartProvider.getProductsWithoutStock();

    if (productsWithoutStock.isNotEmpty) {
      cartProvider.removeProductsWithoutStock();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Hay productos sin stock suficiente. Fueron eliminados del carrito.',
          ),
        ),
      );

      return;
    }

    await sendPurchaseEmail(email, cartProvider);

    cartProvider.buyProducts();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Compra realizada. Stock rebajado y correo enviado a $email.',
        ),
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
                      final item = cartProvider.cart[index];
                      final product = item.product;
                      final stock = cartProvider.getStock(product);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: ListTile(
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
                            'Precio: \$${product.productPrice}\n'
                            'Stock disponible: $stock',
                          ),
                          trailing: SizedBox(
                            width: 130,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    cartProvider.decreaseQuantity(product);
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    cartProvider.increaseQuantity(product);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Productos: ${cartProvider.totalItems}'),
                      const SizedBox(height: 6),
                      Text(
                        'Total: \$${cartProvider.total}',
                        style: const TextStyle(
                          fontSize: 22,
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
