import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/screen/add_post.dart';
import 'package:social/screen/profile.dart';
import 'package:social/screen/time_line.dart';

import '../login/login.dart';
import '../provider.dart';


class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index=0;

  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<MyProvider>(context);


    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF202A44),
        title: Text(
          "Hello",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),

        ),
        actions: [
          IconButton(onPressed: (){
            provider.logOut();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }, icon: Icon(Icons.logout, size: 18,))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AddPostScreen.routeName);
        },
        backgroundColor: Colors.white24,
        child: Icon(Icons.add,size: 30,),

        shape: const StadiumBorder(
            side: BorderSide(
                color:  Colors.white,
                width: 3
            )
        )
        ,),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: index,
          onTap: (value){
            index = value;
            setState(() {});
          },
          iconSize: 30,
          items: [
            BottomNavigationBarItem(icon:
            Icon(Icons.whatshot_outlined),label: ""),
            BottomNavigationBarItem(icon:
            Icon(Icons.person),label: "")
          ],
        ),
      ),
      body: tabs[index],

    );
  }
  List<Widget>tabs=[TimeLineScreen(),ProfileScreen()];


}