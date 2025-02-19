import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tutoial/services/token_storage.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  User user = User();
  final TokenStorage _tokenStorage =  TokenStorage();

  Future<void> _fetchUser() async {
    final token = await _tokenStorage.getToken();
    final url = Uri.parse("https://api.escuelajs.co/api/v1/auth/profile");
    final response = await http.get(url,headers: {
        "Authorization": "Bearer $token"
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        user = User.fromJson(data);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: 90,
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image:
                                CachedNetworkImageProvider(user.avatar ?? ''))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xffFF9C6E),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 3)),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                user.name ?? 'No Name provided',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(user.email ?? 'No Email provided',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        leading: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.orange.withValues(alpha: .2)),
                            child:
                                Icon(Icons.settings, color: Color(0xffFF9C6E))),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xffFF9C6E),
                        ),
                      );
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class User {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;
  String? creationAt;
  String? updatedAt;

  User(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.role,
      this.avatar,
      this.creationAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }
}
