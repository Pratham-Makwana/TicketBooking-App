import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:ticket_booking_app/pages/home_page.dart';
import 'package:ticket_booking_app/widgets/theme.dart';

import '../pages/login_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lighttheme(context),
      darkTheme: MyTheme.darktheme(context),
      home: LoginPage(),
      /*  initialRoute: "login",
      routes: {
        "/": (context) => LoginPage(),
      //  "home": (context) => HomePage(),
        "login": (context) => LoginPage(),
        "signup": (context) => SignupPage(),
      },*/
    );
  }
}
