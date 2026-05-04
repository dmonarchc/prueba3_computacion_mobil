import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/product_form_provider.dart';
import 'package:provider/provider.dart';
import '../../ui/input_decorations.dart';

class FormProduct extends StatelessWidget {
  const FormProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Nombre del producto',
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: '------',
                  labelText: 'Precio',
                ),
              ),
              TextFormField(
                initialValue: product.productImage,
                onChanged: (value) => product.productImage = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'La url es obligatoria';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hinText: 'Agregue una url',
                  labelText: 'URL',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration _createDecoration() => const BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(25),
    bottomRight: Radius.circular(25),
  ),
  boxShadow: [
    BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
  ],
);
