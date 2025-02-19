import 'package:flutter/material.dart';
import 'package:flutter_tutoial/services/category_api.dart';

import '../models/category.dart';

class CategoryProvider extends ChangeNotifier {

  final List<Category> categories = [];
  bool isLoading = true;
  final CategoryApi _categoryApi = CategoryApi();
  Future<void> fetchCategories() async {
    final data = await _categoryApi.fetchCategories();
    categories.addAll(data);
    categories.insert(0, Category(name: 'All'));
    isLoading = false;
    notifyListeners();
  }
}
