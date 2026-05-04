import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/product/detail_product.dart';
import 'package:flutter_application_1/widgets/product/image_product.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';

import '../../models/productos.dart' show Listado;

class CardProduct extends StatelessWidget {
  final Listado product;
  const CardProduct({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 10),
        width: double.infinity,
        decoration: _cardDecoration(),
        child: Stack(
          children: [
            ImageProduct(url: product.productImage),
            DetailProduct(productName: product.productName),
            PriceProduct(productPrice: product.productPrice),

            Positioned(
              bottom: 10,
              right: 10,
              child: ElevatedButton(
                onPressed: () {
                  final cart = Provider.of<CartProvider>(
                    context,
                    listen: false,
                  );
                  cart.addProduct(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Agregado al carrito")),
                  );
                },
                child: const Text("Agregar"),
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
  boxShadow: [
    BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
  ],
);
