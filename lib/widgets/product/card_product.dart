import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/productos.dart' show Listado;
import '../../providers/cart_provider.dart';

class CardProduct extends StatelessWidget {
  final Listado product;

  const CardProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        decoration: _cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25),
              ),
              child: Image.network(
                product.productImage,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported, size: 80),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '\$${product.productPrice}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final cart = Provider.of<CartProvider>(
                          context,
                          listen: false,
                        );

                        cart.addProduct(product);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Agregado al carrito')),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Agregar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _cardDecoration() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(25),
  boxShadow: const [
    BoxShadow(color: Colors.black26, offset: Offset(0, 5), blurRadius: 10),
  ],
);
