// import 'package:flutter/material.dart';
// import 'package:flutter_project1/Classes/DBConnection.dart';
// import 'package:flutter_project1/Widgets/MainStructElement.dart';

// import '../Tables/User.dart';
// import 'LoginPage.dart';

// class RegisterPage extends StatefulWidget {
//   static UserCatalog currentUser = new UserCatalog(
//       email: 'None@gmail.com',
//       password: 'password',
//       favoriteProducts: List.empty());
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final email = TextEditingController();
//   final passwordFirst = TextEditingController();
//   final passwordSecond = TextEditingController();
//   bool isRegistred() {
//     return true;
//   }
//   void openMainScreen(){

//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             TextField(
//               controller: email,
//             ),
//             TextField(
//               controller: passwordFirst,
//             ),
//             TextField(
//               controller: passwordSecond,
//             ),
//             TextButton(
//               onPressed: () async {
//                 if(passwordFirst.text == passwordSecond.text){
//                 final checkUser = await DBConnection.registerUser(email.text, passwordFirst.text);
//                   if (!checkUser) {
//                     showDialog<String>(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: Center( child: Text('Ошибка!')),
//                         content: Text('Пользователь с данным Email адресом уже зарегистрирован!'),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, 'OK'),
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else{
//                     showDialog<String>(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: Center(child: Text('Успех!')),
//                         content: Text('Регистрация прошла успешно, войдите в приложение!'),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
//                               return Login();
//                             })),
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                 } else{
//                   showDialog<String>(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: Center( child: Text('Ошибка!')),
//                         content: Text('Пароли не совпадают!'),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, 'OK'),
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                 }
//               },
//               child: Text('Регистрация'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/Classes/DBConnection.dart';
import 'package:flutter_project1/Classes/firebase_streem.dart';
import 'package:flutter_project1/Pages/LoginPage.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<RegisterPage> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: Text('Ошибка!')),
          content: Text('Пароли не совпадают!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Center(child: Text('Ошибка!')),
            content: Text('Такой email уже используется'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Center(child: Text('Ошибка!')),
            content: Text('Неизвестная ошибка, обратитесь в поддержку'),
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
    DBConnection.registerUser();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return const FirebaseStream();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text('Зарегистрироваться',
          style: GoogleFonts.comfortaa(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          )),
          backgroundColor: Color(0xFF19280D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailTextInputController,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Введите правильный Email'
                        : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Введите Email',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Введите пароль',
                  suffix: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                controller: passwordTextRepeatInputController,
                obscureText: isHiddenPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Введите пароль еще раз',
                  suffix: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30), 
              ElevatedButton(
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
                onPressed: signUp,
                child: Center(child: Text('Регистрация', /////////
                style: GoogleFonts.comfortaa(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 14
                ),
                )),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                    return const Login();
                  }), (route) => false);
                },
                child: const Text(
                  'Войти',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
