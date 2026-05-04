import 'package:flutter/material.dart';

class DetailProduct extends StatelessWidget {
  final String productName;
  const DetailProduct({super.key, required this.productName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 80,
        decoration: _boxDecorations(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _boxDecorations() => const BoxDecoration(
  color: Color.fromARGB(255, 57, 57, 224),
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  ),
);
