import 'package:flutter/material.dart';
import 'package:flutter_tutoial/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> carts = [];

  void addCart(CartItem cartItem) {
    int index = carts.indexWhere((cart) => cart.id == cartItem.id);
    if (index >= 0) {
      carts[index].quantity += cartItem.quantity;
    } else {
      carts.add(cartItem);
    }

    notifyListeners();
  }

  void removeCart(CartItem product) {
    carts.remove(product);
    notifyListeners();
  }

  void updateQty(int cartId, int quantity) {
    int index = carts.indexWhere((cart) => cart.id == cartId);
    carts[index].quantity = quantity;
    notifyListeners();
  }
}
