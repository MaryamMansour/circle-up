import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/firebase/firebase.dart';
import 'package:social/signup/sign_up_viewmodel.dart';
import 'package:social/signup/signup.dart';
import '../../home_layout/home_layout.dart';

import '../base.dart';
import '../login/login.dart';
import '../provider.dart';
import 'signup_connector.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "CreateAcoountScreen";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends BaseView<SignUpViewModel, SignUp> implements SignUpConnector {



  @override
  SignUpViewModel initViewModel() {

    // TODO: implement initViewModel
    return SignUpViewModel();

  }

  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var PassController = TextEditingController();

  var nameController = TextEditingController();

  var ageController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState

    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF202A44),
          title: Text(
            "SignUp",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [


              Container(
                width: 200,
                height: 200,
                color: Colors.transparent, // Container background color
                child:  Image.asset('assets/43.jpg'), // Replace with your image path
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please enter name";
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Name"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.blue))),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!);
                                  if (value.isEmpty) {
                                    return "please enter email";
                                  } else if (!emailValid) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Email"),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.blue))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: PassController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please enter Password";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    label: Text("Password"),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.blue),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white24),
                                onPressed: () {
    //
    // SignUpViewModel.createAcoount(emailController.text.trim(),
    // PassController.text.trim(), nameController.text);
                                  addUserToSF(nameController.text);
                                  FireBaseFunctions.createAcoount(nameController.text,emailController.text.trim(),
                                      PassController.text.trim(),() {
                                        provider.initUser();
                                        Navigator.pushReplacementNamed(
                                            context, HomeLayout.routeName);
                                      });


                                },
                                child: Text("Sign Up")),

                            Row(
                              children: [
                                const SizedBox(
                                  width: 90,
                                ),
                                Text(
                                  "I've an account ?",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.black),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, LoginScreen.routeName);
                                    },
                                    child: Text("Login")),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }
  addUserToSF(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user);
  }


}
