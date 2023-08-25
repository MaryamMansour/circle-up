import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/models/post_model.dart';

import '../widget/Post.dart';
import '../firebase/firebase.dart';
import '../provider.dart';


class TimeLineScreen extends StatefulWidget {

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}
class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return StreamBuilder(
      stream: FireBaseFunctions.getPostsFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Column(
            children: [
              Text("Something is wrong!"),
              ElevatedButton(onPressed: () {}, child: Text("Try Again")),
            ],
          );
        }

        List<PostModel> posts =
            snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

        return ListView.builder(
          itemBuilder: (context, index) => Post(posts[index]),
          itemCount: posts.length,
        );
      },
    );
  }
}














