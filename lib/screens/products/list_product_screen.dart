import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/loadinng_screen.dart';
import 'package:flutter_application_1/services/product_service.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../models/productos.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  String searchText = '';
  String selectedCategory = 'Todos';

  String getCategory(String name) {
    final lower = name.toLowerCase();

    if (lower.contains('monitor')) return 'Tecnología';
    if (lower.contains('lightsaber')) return 'Geek';
    if (lower.contains('panini')) return 'Comida';
    if (lower.contains('pajarillo')) return 'Decoración';

    return 'Otros';
  }

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    if (productService.isLoading) return LoadinngScreen();

    final filteredProducts = productService.products.where((product) {
      final matchesSearch = product.productName.toLowerCase().contains(
        searchText.toLowerCase(),
      );

      final category = getCategory(product.productName);

      final matchesCategory =
          selectedCategory == 'Todos' || category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de productos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'cart');
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Filtrar por categoría',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                DropdownMenuItem(
                  value: 'Tecnología',
                  child: Text('Tecnología'),
                ),
                DropdownMenuItem(value: 'Geek', child: Text('Geek')),
                DropdownMenuItem(value: 'Comida', child: Text('Comida')),
                DropdownMenuItem(
                  value: 'Decoración',
                  child: Text('Decoración'),
                ),
                DropdownMenuItem(value: 'Otros', child: Text('Otros')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar producto',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (BuildContext context, index) {
                final product = filteredProducts[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'product_detail',
                      arguments: product,
                    );
                  },
                  child: CardProduct(product: product),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productService.SelectProduct = Listado(
            productId: 0,
            productName: '',
            productPrice: 0,
            productImage:
                'https://abravidro.org.br/wp-content/uploads/2015/04/sem-imagem4.jpg',
            productState: '',
          );
          Navigator.pushNamed(context, 'edit_product');
        },
      ),
    );
  }
}
