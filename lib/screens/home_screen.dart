import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Menú de inicio',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            Button(textButton: 'Categorías', pathButton: 'Error'),
            Button(textButton: 'Proveedores', pathButton: 'Error'),
            Button(textButton: 'Productos', pathButton: 'list_product'),
          ],
        ),
      ),
    );
  }
}
