
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertravelwild/models/User.dart' as UserApp;



import 'package:fluttertravelwild/models/place.dart';


//  Auth with try catch
class FirebaseApi {
  //  Register
  Future<String?> registerUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException  ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException  ${e.code}");

      return e.code;
    }
  }

  //  Loggin
  Future<String?> logInUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException  ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException  ${e.code}");

      return e.code;
    }
  }

//  CreateUser
  Future<String?> createUser(UserApp.User user) async {
    try {
      final document =
          // await FirebaseFirestore.instance.collection("users").add(user.toJson());
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set(user.toJson());

      return user.uid;
    } on FirebaseException catch (e) {
      print("FirebaseException  ${e.code}");

      return e.code;
    }
  }

  Future<UserApp.User?> getUser(UserApp.User user) async {
    try {
      final document =
          // await FirebaseFirestore.instance.collection("users").add(user.toJson());
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .get();
      // UserApp.User retU = UserApp.User.Empty();
      print("Query");
      print(user.uid);
      print(document.data());
      print("Exit");
      // Persona per = Persona.fromJson(document.get());
      UserApp.User d = UserApp.User.Empty();
      var dat = document.data();

      // jsonDecode(dat);

      return UserApp.User.fromJson(dat!);
    } on FirebaseException catch (e) {
      print("FirebaseException  ${e.code}");
      Map<String, dynamic> dat = {'Error': e.code};
      // return user.toJson();
      return UserApp.User.Empty();
    }
  }

//  CreateUser
  Future<String?> createPlace(Place1 place) async {
    try {
      final document =
          // await FirebaseFirestore.instance.collection("users").add(user.toJson());
          await FirebaseFirestore.instance
              .collection("places")
              .add(place.toJson());

      return place.uid;
    } on FirebaseException catch (e) {
      print("FirebaseException  ${e.code}");

      return e.code;
    }
  }

 
}
