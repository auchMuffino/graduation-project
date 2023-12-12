import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Pages/LoginPage.dart';

import '../Pages/VerificationPage.dart';
import '../Tables/User.dart';
import '../Widgets/MainStructElement.dart';

class FirebaseStream extends StatefulWidget {
  const FirebaseStream({super.key});
  static UserCatalog currentUser=new UserCatalog(email: 'None@gmail.com', favoriteProducts: List.empty());

  @override
  State<FirebaseStream> createState() => _FirebaseStreamState();
}

class _FirebaseStreamState extends State<FirebaseStream> {
  @override
  void initState(){
    DBConnection.checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(child: Text('Что-то пошло не так!')));
        } else if (snapshot.hasData) {
          if (!snapshot.data!.emailVerified) {
            return const VerificationPage();
          }
          return const Bones();
        } else {
          return const Login();
        }
      },
    );
  }
}
