import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/screen/add_post.dart';
import 'package:social/screen/profile.dart';
import 'package:social/provider.dart';
import 'package:social/signup/signup.dart';

import 'firebase/firebase_options.dart';
import 'home_layout/home_layout.dart';
import 'login/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('username');
  print(email);
  runApp(ChangeNotifierProvider(
      create:(context) =>  MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);


    return MaterialApp(
      initialRoute:  provider.firebaseUser!=null?
      HomeLayout.routeName:
      LoginScreen.routeName,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        AddPostScreen.routeName: (context) => AddPostScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUp.routeName: (context)=>SignUp()
        // CreateAcoount.routeName: (context)=>CreateAcoount(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}