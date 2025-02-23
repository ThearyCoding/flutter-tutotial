import 'package:flutter/material.dart';
import 'package:flutter_tutoial/models/user.dart';
import 'package:flutter_tutoial/services/user_api.dart';

class UserProvider extends ChangeNotifier{
  bool isLoading = false;
  User user = User();
  final UserApi _userApi = UserApi();
  UserProvider(){
    fetchUser();
  }


  Future<void> fetchUser() async{
    setLoading(true);
    user = await _userApi.fetchUser();
    setLoading(false);
  }

  void setLoading(bool value){
    isLoading = value;
    notifyListeners();
  }
}