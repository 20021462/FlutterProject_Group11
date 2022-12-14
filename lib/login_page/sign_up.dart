import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/login_page/login_page.dart';
import 'package:hello_world/login_page/verify_email.dart';

import '../design_system.dart';
import '../firebase.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool failed = false;
  String error='';
  bool hidePassword = true;

  void _signup() async {
    try{
      final User user = (
          await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
      ).user;
      if(user != null) {
        DatabaseManager.userSetup(_emailController.text);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => VerifyScreen(email: _emailController.text,)));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        error=e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>LoginPage())
              );
            },
          ),
          centerTitle: true ,
          title: const Text("Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 100, left: 20, right: 30),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey,width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:  BorderSide(color: Colors.grey.shade900),
                      ),
                    ),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 25,),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey,width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:  BorderSide(color: Colors.grey.shade900),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword=!hidePassword;
                              });
                            },
                            icon: Icon(hidePassword? Icons.remove_red_eye_outlined: Icons.remove_red_eye))
                    ),
                    obscureText: hidePassword,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red),
                      )
                  ),
                  const SizedBox(height: 20,),
                  buildButton("Sign up", large, colorType1, () async {
                    _signup();
                  },)
                ],
              ),
            )
          ],
        )
    );
  }
}
