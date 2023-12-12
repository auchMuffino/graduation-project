import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Widgets/MainStructElement.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerificationPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState(){
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    } else{
      init();
    }
  }
  void init() async{
    await DBConnection.checkUser();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    print(isEmailVerified);

    if (isEmailVerified) {
      timer?.cancel();
      await DBConnection.checkUser();
    };
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));

      setState(() => canResendEmail = true);
    } catch (e) {
      print(e);
      if (mounted) {
        showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Неизвестная ошибка, обратитесь к поддержке'),
          content: Text(''),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      }
    }
  }

  @override
  Widget build(BuildContext context){ 
    if(isEmailVerified){
      return Bones();
    } else{
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Center(
              child: Text('Верификация Email адреса',
              style: GoogleFonts.comfortaa(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              ),
            ),
            backgroundColor: Color(0xFF19280D),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Письмо с подтверждением было отправлено на вашу электронную почту.',
                    style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(70, 40),
                      backgroundColor: Color(0xFF19280D),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5)
                        )
                      )
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    icon: const Icon(Icons.email),
                    label: Text('Повторно отправить', 
                    style: GoogleFonts.comfortaa(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      timer?.cancel();
                      await FirebaseAuth.instance.currentUser!.delete();
                    },
                    child: const Text(
                      'Отменить',
                      style: TextStyle(
                        color: Colors.blue,
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
}
