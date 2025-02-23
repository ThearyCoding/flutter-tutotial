import 'package:flutter/material.dart';
import 'package:flutter_tutoial/providers/auth_provider.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _txtemail = TextEditingController();
  final TextEditingController _txtpassword = TextEditingController();



  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        toolbarHeight: 40,
        leading: Container(
            margin: EdgeInsets.only(left: 20),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300)),
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 230, 243),
                          borderRadius: BorderRadius.circular(100)),
                      child: Image.asset(
                          width: 100, 'assets/images/Platzi-shop.png')),
                ),
              ),
              Text(
                "Login",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              Text(
                "Login to continue using the app",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              TextField(
                controller: _txtemail,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 239, 246),
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              TextField(
                controller: _txtpassword,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye),
                  filled: true,
                  fillColor: Color.fromARGB(255, 235, 239, 246),
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<AuthProvider>(
                builder: (context,authProvider,_) => SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0265FF)),
                      onPressed: () async {
                        await authProvider.login(context, _txtemail.text.trim(), _txtpassword.text.trim());
                      },
                      child: authProvider.isLoading ? CircularProgressIndicator(): Text(
                        "Login",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or Login with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                spacing: 30,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Image.asset(
                        width: 100,
                        height: 70,
                        'assets/images/facebook-logo.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Image.asset(
                        width: 100,
                        height: 70,
                        'assets/images/facebook-logo.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Image.asset(
                        width: 100,
                        height: 70,
                        'assets/images/facebook-logo.png'),
                  )
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: ' Register',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
