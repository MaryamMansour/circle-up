// import 'package:flutter/material.dart';
// import 'package:social/firebase.dart';
//
// import 'models/post_model.dart';
// import 'models/user_model.dart';
//
// class Post extends StatefulWidget {
//   PostModel post;
//
//   Post(this.post);
//
//   @override
//   _PostState createState() => _PostState();
// }
//
// class _PostState extends State<Post> {
//   List<String> comments = [];
//   int likeCount = 0;
//   bool isLiked = false;
//
//   void _showCommentDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String newComment = '';
//
//         return AlertDialog(
//           title: Text('Add Comment'),
//           content: TextField(
//             onChanged: (value) {
//               setState(() {
//                 newComment = value;
//               });
//             },
//             decoration: InputDecoration(
//               hintText: 'Enter your comment...',
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//
//                   comments.add(newComment);
//                 });
//                 Navigator.pop(context);
//                 // FireBaseFunctions.updatePost(widget.post.id,widget.post);
//               },
//               child: Text('Add'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _toggleLike() {
//     setState(() {
//       if (isLiked) {
//         if (likeCount > 0) {
//           likeCount--;
//         }
//       } else {
//         likeCount++;
//       }
//       isLiked = !isLiked;
//     });
//
//
//     // Update the post in Firestore here
//     // Call a function that updates the post in Firestore
//     // FireBaseFunctions.updatePost(widget.post.id,widget.post);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Colors.grey,
//                     backgroundImage: NetworkImage(
//                       'https://example.com/user_profile_image.jpg',
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     widget.post.username ?? 'User',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Divider(),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Text(
//                 widget.post.content,
//                 style: TextStyle(fontSize: 14),
//               ),
//             ),
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: _showCommentDialog,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: _toggleLike,
//                       child: Row(
//                         children: [
//                           Icon(isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined),
//                           SizedBox(width: 5),
//                           Text(likeCount.toString()),
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: _showCommentDialog,
//                       child: Icon(Icons.comment),
//                     ),
//                     Icon(Icons.share),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Column(
//               children: (comments ?? []).map((comment) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(comment),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:social/firebase/firebase.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class Post extends StatefulWidget {
  PostModel post;

  Post(this.post);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  int likeCount = 0;
  bool isLiked = false;
  List<String> comments = [];

  @override
  void initState() {
    super.initState();
    likeCount = widget.post.likeCount ?? 0;
    comments = widget.post.comments ?? [];
  }

  void _showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newComment = '';

        return AlertDialog(
          title: Text('Add Comment'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                newComment = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter your comment...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {

                  comments.add(newComment);
                });
                Navigator.pop(context);
                widget.post.comments= comments;

                FireBaseFunctions.updatePost(widget.post.id,widget.post);
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }


  void _toggleLike() {
    setState(() {
      if (isLiked) {
        if (likeCount > 0) {
          likeCount--;
        }
      } else {
        likeCount++;
      }
      isLiked = !isLiked;
    });



    widget.post.likeCount = likeCount;
    // Update the post in Firestore here
    // Call a function that updates the post in Firestore
    FireBaseFunctions.updatePost(widget.post.id,widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      'https://example.com/user_profile_image.jpg',
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.post.username ?? 'User',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.post.content,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _showCommentDialog,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _toggleLike,
                      child: Row(
                        children: [
                          Icon(isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined),
                          SizedBox(width: 5),
                          Text(likeCount.toString()),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _showCommentDialog,
                      child: Icon(Icons.comment),
                    ),
                    Icon(Icons.share),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // Column(
            //   children: (widget.post.comments ?? []).map((comment) {
            //     return Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 10),
            //       child: Text(comment),
            //     );
            //   }).toList(),
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ... your existing code ...

                SizedBox(height: 10),

                Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.post.comments?.length ?? 0,
                  itemBuilder: (context, index) {
                    String comment = widget.post.comments![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              'https://example.com/user_profile_image.jpg',
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            comment,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: 10),
              ],
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }


}