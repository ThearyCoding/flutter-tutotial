import 'package:flutter/material.dart';
import 'package:flutter_tutoial/services/product_api.dart';
import '../../models/product.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider(){
    fetchProducts();
  }
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
    setLoading(false);
  }

  Future<void> filterProducts(
      double minPrice, double maxPrice, int categoryId) async {
    setLoading(true);
    products.clear();
    if (selectedIndex == 0) {
      await fetchProducts();
    } else {
      final data =
          await _productApi.filterProduct(minPrice, maxPrice, categoryId);
      products.addAll(data);
    }

    setLoading(false);
  }

  Future<void> fetchProductByCategoryId(int categoryId) async {
    setLoading(true);
    products.clear();
    final productdata = await _productApi.fetchProductByCategoryId(categoryId);
    products.addAll(productdata);
    setLoading(false);
  }

  Future<void> searchProductByTitle(String title) async {
    setLoading(true);
    products.clear();
    final productdata = await _productApi.searchProductByTitle(title);
    products.addAll(productdata);
    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
