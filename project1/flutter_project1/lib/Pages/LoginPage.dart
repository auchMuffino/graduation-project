import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Widgets/MainStructElement.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool isRegistred() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: email,
            ),
            TextField(
              controller: password,
            ),
            TextButton(
              onPressed: () async {
                if (await DBConnection.checkUser(email.text, password.text)) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    // return ProductInfoPage(productID: ProductCard.productID);
                    return Bones();
                  }));
                }
              },
              child: Text('Вход'),
            ),
          ],
        ),
      ),
    );
  }
}
