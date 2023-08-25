import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class FireBaseFunctions{


  // IT point on the collection
  static CollectionReference<PostModel> getPostsCollection()
  {
    return FirebaseFirestore.instance.collection(PostModel.COLLECTION_NAME)
        .withConverter<PostModel>(
      fromFirestore: (snapshot,_) => PostModel.fromJson(snapshot.data()!),
      toFirestore: (task,_) => task.toJson(),
    );
  }

  //Both are static bc
  // I want to call it by class directly

  static Future<void> addPostToFirestore(PostModel post){
    var collection = getPostsCollection();
    var docRef= collection.doc();
    post.id= docRef.id; //عشان التاسم ملهاش اي دي هاخدها من الدوك
    return docRef.set(post); // و باقي الحجات الفاضية هعملها سيت ب اللي عندي ف التاسك
  }


  static Stream<QuerySnapshot<PostModel>> getPostsFromFirestore()
  {
    var collection = getPostsCollection();
    return collection.snapshots();
  }
  // static Future<void> deleteTask(String id )
  // {
  //   return getTaskCollection().doc(id).delete();
  // }

  // static Future<void> updateTask(String id , TaskModel task){
  //   return getTaskCollection().doc(id).update(task.toJson());
  // }


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
      //credential.user!.sendEmailVerification(); email verify
      //FirebaseAuth.instance.sendPasswordResetEmail(email: "email")
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