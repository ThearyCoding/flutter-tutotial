import 'package:flutter/material.dart';
import 'package:flutter_tutoial/services/product_api.dart';
import '../../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> products = [];
  final ProductApi _productApi = ProductApi();
  bool isLoading = true;
  int selectedIndex = 0;

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    final productData = await _productApi.fetchProducts();
    products.addAll(productData);
    isLoading = false;
    notifyListeners();
  }

  Future<void> filterProducts(
      double minPrice, double maxPrice, int categoryId) async {
    isLoading = false;
    notifyListeners();
    products.clear();
    if (selectedIndex == 0) {
      await fetchProducts();
    } else {
      final data =
          await _productApi.filterProduct(minPrice, maxPrice, categoryId);
      products.addAll(data);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProductByCategoryId(int categoryId) async {
    isLoading = true;
    notifyListeners();
    products.clear();
    final productdata = await _productApi.fetchProductByCategoryId(categoryId);
    products.addAll(productdata);
    isLoading = false;
    notifyListeners();
  }

  Future<void> searchProductByTitle(String title) async {
    isLoading = true;
    notifyListeners();
    products.clear();
    final productdata = await _productApi.searchProductByTitle(title);
    products.addAll(productdata);
    isLoading = false;
    notifyListeners();
  }
}
