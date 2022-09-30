import 'package:flutter/material.dart';
import 'package:hello_world/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'back_end/moma_user.dart';

// const MaterialColor primaryBlack = MaterialColor(
//   _blackPrimaryValue,
//   <int, Color>{
//     50: Color(0xFF000000),
//     100: Color(0xFF000000),
//     200: Color(0xFF000000),
//     300: Color(0xFF000000),
//     400: Color(0xFF000000),
//     500: Color(_blackPrimaryValue),
//     600: Color(0xFF000000),
//     700: Color(0xFF000000),
//     800: Color(0xFF000000),
//     900: Color(0xFF000000),
//   },
// );
// const int _blackPrimaryValue = 0xFF000000;

void main() async {
  MomaUser appUser = MomaUser("test@gmail.com");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    appUser: appUser,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MomaUser appUser;

  MyApp({Key key, this.appUser}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOMA',
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      home: HomePage(appUser: appUser),
      //home: NewPage(),
      debugShowCheckedModeBanner: false,
      // routes: <String, WidgetBuilder>{
      //   '/signup': (BuildContext context) => SignupPage(),
      //   '/reset_password': (BuildContext context) => ResetPassword(),
      //   '/main_screen': (BuildContext context) => MainScreen(appUser: appUser ,),
      // },
    );
  }
}
