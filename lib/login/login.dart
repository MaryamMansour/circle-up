import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base.dart';
import '../home_layout/home_layout.dart';
import '../provider.dart';
import '../signup/signup.dart';
import 'login_connector.dart';
import 'login_viewmodel.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginViewModel, LoginScreen> implements LoginConnector  {
  var emailController=TextEditingController();

  var PassController = TextEditingController();
  var nameController = TextEditingController();

  var formKey=GlobalKey<FormState>();


  void initState(){
    super.initState();
    viewModel.connector=this;
  }

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);



    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) =>  Scaffold(
        backgroundColor: Colors.white,

        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor:Color(0xFF202A44),
          title: Text(
            "Login",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
        ),
        body:



        Column(
          children: [

            Container(
              width: 200,
              height: 200,
              color: Colors.transparent, // Container background color
              child: Image.asset('assets/21.jpg'), // Replace with your image path
            ),

            Card(
              margin: EdgeInsets.all(20),
              child: Expanded(

                child: Container(

                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(height: 50,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value){
                              bool emailValid =
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if( value.isEmpty){
                                return "please enter email";
                              }
                              else if (!emailValid)
                              {
                                return "Please enter valid email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Email"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue
                                    )
                                )
                            ),
                          ),
                        ),  SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                label: Text("Name"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.blue
                                    )
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: PassController,
                            obscureText: true,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return "please enter Password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Password"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: Colors.blue
                                  ),
                                )
                            ),
                          ),
                        ),

                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white24,)
                            ,onPressed: (){
                          if(formKey.currentState!.validate())
                          {
                            addUserToSF(nameController.text);
                            viewModel.login(emailController.text, PassController.text);

                          }

                        }
                            , child:Text("Login") ),

                        Row(

                          children: [
                            SizedBox(width: 50,),
                            Text("Don't have an account ?",
                              style: GoogleFonts.quicksand(
                                  fontSize:12,
                                  color: Colors.black54
                              ),),
                            SizedBox(height: 4,),
                            TextButton(
                                style: TextButton.styleFrom(
                                    primary: Colors.black),
                                onPressed: (){
                                  Navigator.pushReplacementNamed(context, SignUp.routeName);
                                },
                                child: Text("Create Account"))
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }
  addUserToSF(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user);
  }


}

