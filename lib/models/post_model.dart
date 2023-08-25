// import 'package:social/models/user_model.dart';
//
// class PostModel{
//
//   static const String COLLECTION_NAME="Posts";
//   String id;
//   String content;
//   String? username;
//   int? likeCount;
//   // List<String>? comments;
//
//
//
//   PostModel({this.id='',
//     required this.username,
//     required this.content,
//     required this.likeCount,
//      // this.comments,
//   });
//
//   PostModel.fromJson(Map<String, dynamic>json): this(
//
//     id: json['id'],
//     content: json['content'],
//     username: json['username'],
//       // comments: json['comments'],
//     likeCount : json['likeCount']
//
//   );
//
//   Map<String, dynamic> toJson()
//   {
//     return{
//       "id":id,
//       "content":content,
//       "username":username,
//       // "comments":comments,
//       "likeCount":likeCount
//
//     };
//
//   }
//
// }

class PostModel {
  static const String COLLECTION_NAME = "Posts";
  String id;
  String content;
  String? username;
  int? likeCount;
  List<String>? comments; // Change here

  PostModel({
    this.id = '',
    required this.username,
    required this.content,
    this.likeCount,
    this.comments,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    content: json['content'],
    username: json['username'],
    likeCount: json['likeCount'],
    comments: json['comments'] != null
        ? List<String>.from(json['comments'])
        : null,
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "username": username,
      "likeCount": likeCount,
      "comments": comments,
    };
  }
}
