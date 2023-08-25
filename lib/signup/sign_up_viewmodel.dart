import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';
import '../base.dart';
import '../firebase/firebase.dart';
import 'signup_connector.dart';

class SignUpViewModel extends BaseViewModel<SignUpConnector>{


  static void createAcoount (String name,String email, String password)async{
    try {
      final credential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel(id: credential.user!.uid
          ,name: name, email: email);
      FireBaseFunctions.addUserToFirestore(userModel).then((value) {});

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
}