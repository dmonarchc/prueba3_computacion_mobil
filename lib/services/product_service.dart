import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/productos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Listado> products = [];
  Listado? SelectProduct;
  bool isLoading = true;
  bool isEditCreate = true;

  ProductService() {
    loadProducts();
  }
  Future loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(_baseUrl, 'ejemplos/product_list_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    print(response.body);
    final productMap = Product.fromJson(response.body);
    products = productMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProducts(Listado product) async {
    isEditCreate = true;
    notifyListeners();
    if (product.productId == 0) {
      await this.createProduct(product);
    } else {
      await this.updateProduct(product);
    }
    isEditCreate = false;
    notifyListeners();
  }

  Future updateProduct(Listado product) async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(
      url,
      body: product.toJson(),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final decodeResponse = response.body;
    print(decodeResponse);
    //actualizar el listado
    final index = products.indexWhere(
      (element) => element.productId == product.productId,
    );
    products[index] = product;
    return '';
  }

  Future createProduct(Listado product) async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(
      url,
      body: product.toJson(),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final decodeResponse = response.body;
    print(decodeResponse);
    //agregar al listado
    this.products.add(product);
    return '';
  }

  Future deleteProduct(Listado product, BuildContext context) async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(
      url,
      body: product.toJson(),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final decodeResponse = response.body;
    print(decodeResponse);
    //eliminar del listado
    this.products.clear();
    loadProducts();
    Navigator.of(context).pushNamed('list_product');
    return "";
  }
}
