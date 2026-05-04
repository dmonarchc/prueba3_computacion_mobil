#  Aplicación Flutter – Tienda de Productos

##  Descripción
Aplicación móvil desarrollada en Flutter que implementa autenticación de usuarios, gestión de productos y un flujo completo de compra, utilizando Firebase Authentication y una API REST proporcionada por el profesor.

##  Tecnologías utilizadas
- Flutter (Dart)
- Firebase Authentication
- API REST (backend entregado)
- Provider (gestión de estado)
- Postman (pruebas)
- url_launcher (correo)

##  Autenticación (Firebase)
Se implementó autenticación mediante Firebase Authentication:
- Registro de usuarios
- Inicio de sesión
- Recuperación de contraseña (correo real necesario para que llegue el mail de reset de password)

API utilizada:
https://identitytoolkit.googleapis.com

##  Gestión de Productos (API REST)
Endpoints:
- GET /ejemplos/product_list_rest/
- POST /ejemplos/product_add_rest/
- POST /ejemplos/product_edit_rest/
- POST /ejemplos/product_del_rest/

Auth:
Usuario: test
Contraseña: test2023

##  Funcionalidades
- Listado de productos
- Buscador
- Filtro por categorías (simulado)
- Detalle de producto
- Carrito de compras
- Selección de cantidad
- Validación de stock
- Compra con correo

##  Stock
Implementado de forma simulada en memoria, con validación y rebaja tras la compra.

##  Correo
Se utiliza url_launcher para abrir el cliente de correo con los datos de la compra.

##  Postman
Se probaron todos los endpoints con evidencias:
- GET
- POST create
- POST edit
- POST delete

##  Ejecución
flutter pub get
flutter run

##  Conclusión
La aplicación cumple con autenticación, CRUD, carrito, compra, validación de stock y uso de API externa.
