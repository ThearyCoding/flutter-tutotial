import 'package:flutter/material.dart';
import 'package:flutter_tutoial/services/auth_api.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  final AuthApi _authApi = AuthApi();

  Future<void> login(
      BuildContext context, String email, String password) async {
    setLoading(true);
    await _authApi.login(context, email, password);
    setLoading(false);
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
