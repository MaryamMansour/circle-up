import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class FireBaseFunctions{



  static CollectionReference<PostModel> getPostsCollection()
  {
    return FirebaseFirestore.instance.collection(PostModel.COLLECTION_NAME)
        .withConverter<PostModel>(
      fromFirestore: (snapshot,_) => PostModel.fromJson(snapshot.data()!),
      toFirestore: (task,_) => task.toJson(),
    );
  }



  static Future<void> addPostToFirestore(PostModel post){
    var collection = getPostsCollection();
    var docRef= collection.doc();
    post.id= docRef.id;
    return docRef.set(post);
  }


  static Stream<QuerySnapshot<PostModel>> getPostsFromFirestore()
  {
    var collection = getPostsCollection();
    return collection.snapshots();
  }


  static Future<UserModel?> readUser(String id)async{

    DocumentSnapshot<UserModel> userSnap=
    await getUserCollection().doc(id).get();
    return userSnap.data();
  }



  static void createAcoount (String name,String email, String password, Function created)async{
    try {
      final credential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(id: credential.user!.uid
          ,name: name, email: email);
      addUserToFirestore(userModel).then((value) {created();});

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.message);
      } else if (e.code == 'email-already-in-use') {
        print(e.message);
      }
    } catch (e) {
      print(e);
    }
  }






  static CollectionReference<UserModel> getUserCollection()
  {
    return FirebaseFirestore.instance.
    collection(UserModel.COLLECTION_NAME)
        .withConverter<UserModel>(
        fromFirestore: (snapshot,options) {
          return UserModel.fromJson(snapshot.data()!);
        },
        toFirestore: (user,options) {
          return user.toJson();
        }
    );
  }

  static Future<void> updatePost(String id , PostModel post){
    return getPostsCollection().doc(id).update(post.toJson());
  }


  static Future <void> addUserToFirestore(UserModel user){
    var collection = getUserCollection();
    var docRef= collection.doc(user.id);
    return docRef.set(user);
  }


}