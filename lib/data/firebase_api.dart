// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:mislibros/models/book.dart';
import 'package:fluttertravelwild/models/User.dart' as UserApp;

import 'dart:convert';

// import 'package:flutter/material.dart';
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
// createBook
  // Future<String> createBook(Book book) async {
  //   try {
  //     final uid = FirebaseAuth.instance.currentUser?.uid;
  //     final document = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .collection('books')
  //         .doc();
  //     book.id = document.id;
  //     final result = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .collection('books')
  //         .doc(book.id)
  //         .set(book.toJson());
  //     return book.id;
  //   } on FirebaseException catch (e) {
  //     return e.code;
  //   }
  // }
}
