import 'dart:convert';
import 'package:flutter_tutoial/core/constant.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductApi{
   Future<List<Product>> fetchProducts() async {
    final url = Uri.parse("$baseUrl/products");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      print(response.body);
      return [];
    }
  }

   Future<List<Product>> fetchProductByCategoryId(int categoryId) async {
    final url = Uri.parse(
        "$baseUrl/products/?categoryId=$categoryId");

    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      print(response.body);
      return [];
    }
  }
  Future<List<Product>> filterProduct(
      double minPrice, double maxPrice, int categoryId) async {
    final url = Uri.parse(
        "$baseUrl/products/?price_min=$minPrice&price_max=$maxPrice&categoryId=$categoryId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List;
      
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      print(response.body);
      return [];
    }
  }

  
  Future<List<Product>> searchProductByTitle(String title) async {
    final url =
        Uri.parse("$baseUrl/products/?title=$title");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      print(response.body);
      return [];
    }
  }

}