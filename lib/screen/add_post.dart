import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/firebase/firebase.dart';
import 'package:social/models/post_model.dart';
import 'package:social/models/user_model.dart';

import '../provider.dart';


class AddPostScreen extends StatefulWidget {
  static const String routeName = "AddPostScreen";

  @override
  State<AddPostScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<AddPostScreen> {

  var descriptionController = TextEditingController();
  List<String> comments = [];

  late String? stringValue;

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF202A44),
        title: Text(
          "Post",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, left: 10,right: 10,top: 50),//padding for Keyboard only from bottom
          // padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),

          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [

                SizedBox(height: 30,),
                Text("What's on your mind..", style: Theme.of(context).textTheme
                    .bodyLarge!.copyWith(
                    color: Colors.black26
                ), textAlign: TextAlign.start,),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                      controller: descriptionController,
                      maxLines: 10,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          errorStyle: Theme.of(context).textTheme.bodySmall!.
                          copyWith(color: Colors.red, fontSize:12 ),

                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                  color: Colors.white24
                              )
                          )
                      )
                  ),
                ),
                SizedBox(height: 40,),


                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();

                      String? user = prefs.getString('username');
                      print("user");
                     PostModel post = PostModel(content: descriptionController.text.trim(), username: user);

                      FireBaseFunctions.addPostToFirestore(post);

                    }, child: Text("Post")),
                SizedBox(height: 30,),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? user = prefs.getString('username');
    stringValue = prefs.getString('username');
    return user;
  }


}