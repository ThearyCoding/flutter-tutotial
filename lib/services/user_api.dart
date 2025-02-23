import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'token_storage.dart';

class UserApi {
    final TokenStorage _tokenStorage =  TokenStorage();
  Future<User> fetchUser() async {
    final token = await _tokenStorage.getToken();
    final url = Uri.parse("https://api.escuelajs.co/api/v1/auth/profile");
    final response = await http.get(url,headers: {
        "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    }else{
      return User();
    }
  }
}