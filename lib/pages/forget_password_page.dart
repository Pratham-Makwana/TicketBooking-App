import 'package:flutter/material.dart';
import 'package:ticket_booking_app/model/auth_controll.dart';
import 'package:get/get.dart';
import 'package:ticket_booking_app/pages/login_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  bool changebutton = false;
  bool seecurrentpwd = true;
  bool seenewpwd = true;
  bool seeconfimepwd = true;

  final _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  AuthController authController=Get.put(AuthController());

  //Function to move to login page
  moveTologinpage(BuildContext context)async{
    if(_formkey.currentState!.validate()){
      setState(() {
        changebutton = true;
      });
      await Future.delayed(Duration(seconds: 2));
      await authController.forgotPassword(email.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
      setState(() {
        changebutton = false;
      });
    }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset("assets/Images/Forgot_password.png",fit: BoxFit.cover,),
              const SizedBox(
                height: 20,
              ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Forgot Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xff4c505b)),),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
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
                      InkWell(
                        onTap: ()=>moveTologinpage(context),
                        child: AnimatedContainer(duration: Duration(seconds: 1),
                        height: 50,
                          width: changebutton?50:150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular( changebutton ?50:8)
                          ),
                          child: changebutton ?Icon(Icons.done):Text("Confirm",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          ),
          ),
        ),
      ),
    );
  }
}
