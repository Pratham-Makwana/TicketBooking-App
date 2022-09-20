import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/pages/signup_page.dart';

import '../model/auth_controll.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController authController = Get.put(AuthController());

  bool seepwd = true;
  bool changebutton =false;
  final _formkey = GlobalKey<FormState>();


  loginUser() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.getString('token');
    if(preferences.getString('token')==null){
      const LoginPage();
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false);
      //HomeScreen();
    }
  }
// navigation and animation button code
  moveToHome(BuildContext context) async{
    if(_formkey.currentState!.validate()) {

      setState(() {
        changebutton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await authController.LoginIn(context, username.text, password.text);
      // Navigator.push(
      //  context, MaterialPageRoute(builder: (context) => HomePage()),);
      setState(() {
        changebutton = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white ,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20),
              child: Column(
                children: [
                  Image.asset(
                    "assets/Images/login.png",
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("LogIn",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Color(0xff4c505b)),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //------Textformfiled code-------------
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Enter Your Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        labelText: "Email"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: seepwd ,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "Enter Passsword",
                        suffixIcon: IconButton(
                          icon: Icon( seepwd ? Icons.visibility_off : Icons.visibility),
                          //icon:seepwd== false ?Icon(Icons.remove_red_eye_outlined ): Icon(Icons.remove_red_eye) ,
                          onPressed: (){
                            setState(() {
                              seepwd=!seepwd;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      } else if (value.length < 6) {
                        return "Password length should be atleast 6";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //-----------Login Button code---------------
                  InkWell(
                    onTap: () => moveToHome(context),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width:changebutton? 50: 150,
                      height: 50,
                      alignment: Alignment.center,
                      child:changebutton? Icon(Icons.done):Text("Login",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,fontSize: 18),),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(changebutton ? 50:8)
                        //shape: changebutton ? BoxShape.circle : BoxShape.rectangle
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    child: Column(
                      children: [
                        Text("---------- or ----------",style: TextStyle(fontSize: 20, ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  // -------------Sign up text code--------------
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.white70,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()),);

                          }, child: Text("Sign Up",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),))

                  ),
                  // ----------------------- Sign up with Google Button Code -------------------
                  SignInButton(Buttons.Google,
                      text: "Sign Up With Google",
                      elevation: 5,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ), onPressed: (){
                        signup(context);
                      }//{Navigator.pushNamed(context, 'home');})
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
