import 'package:flutter/material.dart';
import 'package:ticket_booking_app/model/auth_controll.dart';
import 'package:get/get.dart';

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

  TextEditingController currentpwd = TextEditingController();
  TextEditingController newpwd = TextEditingController();
  TextEditingController confirmpwd = TextEditingController();
  AuthController authController=Get.put(AuthController());

  //Function to move to login page
  moveTologinpage(BuildContext context)async{
    if(_formkey.currentState!.validate()){
      setState(() {
        changebutton = true;
      });
      await Future.delayed(Duration(seconds: 2));
      await authController.changePassword(currentpwd.text,newpwd.text);
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
                      Text("Forget Password",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xff4c505b)),),
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
                        controller: currentpwd,
                        obscureText: seecurrentpwd,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon( seecurrentpwd ? Icons.visibility_off : Icons.visibility),
                              //icon:seepwd== false ?Icon(Icons.remove_red_eye_outlined ): Icon(Icons.remove_red_eye) ,
                              onPressed: (){
                                setState(() {
                                  seecurrentpwd=!seecurrentpwd;
                                });
                              },
                            ),
                            border:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Current Password',
                            hintText: 'Enter Your Current Password'
                        ),
                        validator: (value){
                          if (value!.isEmpty){
                            return "Password cannot be Empty";
                          }
                          else if(value.length < 6){
                            return "Password length should be atleast 6";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: newpwd,
                        obscureText: seenewpwd,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon( seenewpwd ? Icons.visibility_off : Icons.visibility),
                              //icon:seepwd== false ?Icon(Icons.remove_red_eye_outlined ): Icon(Icons.remove_red_eye) ,
                              onPressed: (){
                                setState(() {
                                  seenewpwd=!seenewpwd;
                                });
                              },
                            ),
                            border:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: ' New Password',
                            hintText: 'Enter Your New Password'
                        ),
                        validator: (value){
                          if (value!.isEmpty){
                            return "Password cannot be Empty";
                          }
                          else if(value.length < 6){
                            return "Password length should be atleast 6";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: confirmpwd,
                        obscureText: seeconfimepwd,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon( seeconfimepwd ? Icons.visibility_off : Icons.visibility),
                              //icon:seepwd== false ?Icon(Icons.remove_red_eye_outlined ): Icon(Icons.remove_red_eye) ,
                              onPressed: (){
                                setState(() {
                                  seeconfimepwd=!seeconfimepwd;
                                });
                              },
                            ),
                            border:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Confirm Password',
                            hintText: 'Enter Confirm Password'
                        ),
                        validator: (value){
                          if (value!.isEmpty){
                            return "Password cannot be Empty";
                          }
                          else if(value.length < 6){
                            return "Password length should be atleast 6";
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
