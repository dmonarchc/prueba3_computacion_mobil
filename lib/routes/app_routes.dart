import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';
import 'package:flutter_application_1/screens/products/product_detail_screen.dart';

import '../screens/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'register': (BuildContext context) => const RegisterScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'list_product': (BuildContext context) => const ListProductScreen(),
    'edit_product': (BuildContext context) => const EditProductScreen(),
    'product_detail': (_) => const ProductDetailScreen(),
    'cart': (_) => const CartScreen(),
    'error': (BuildContext context) => const ErrorScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }
}
