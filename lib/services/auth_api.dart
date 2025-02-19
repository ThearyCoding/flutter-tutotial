import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tutoial/core/constant.dart';
import 'package:http/http.dart' as http;

import '../views/home_page.dart';
import 'token_storage.dart';

class AuthApi {
  final TokenStorage _tokenStorage = TokenStorage();
  Future<void> login(
      BuildContext context, String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      final token = jsonDecode(response.body)['access_token'];
      await _tokenStorage.saveToken(token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => HomePage()),
      );
    } else {
      log("error login: ${response.statusCode}, ${response.body}");
    }
  }
}
