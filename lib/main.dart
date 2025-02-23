import 'package:flutter/material.dart';
import 'package:flutter_tutoial/providers/cart_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/category_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/user_provider.dart';
import '../../views/login_page.dart';
import '../../services/token_storage.dart';
import 'package:provider/provider.dart';
import 'views/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CategoryProvider()),
    ChangeNotifierProvider(create: (context) => ProductProvider()),
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TokenStorage _tokenStorage = TokenStorage();
  bool isLogin = false;
  Future<void> _isLogin() async {
    final token = await _tokenStorage.getToken();
    setState(() {
      if (token != null) {
        isLogin = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLogin ? MainPage() : LoginPage(),
    );
  }
}
