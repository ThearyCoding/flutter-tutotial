import 'dart:convert';

import 'package:flutter_tutoial/core/constant.dart';

import '../models/category.dart';
import 'package:http/http.dart' as http;
class CategoryApi {

    Future<List<Category>> fetchCategories() async {
    final url = Uri.parse("$baseUrl/categories");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as List;
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      return [];
    }
  }
}