import 'package:flutter_tutoial/models/product.dart';

class CartItem {
  final int id;
  final Product product;
   int quantity;

  CartItem({required this.id, required this.product, required this.quantity});
}
