import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xyz/helper/constant.dart';

class User {
  String email;
  String nama;
  String telepon;
  String password;
  String role;

  User(
      {required this.email,
      required this.nama,
      required this.telepon,
      required this.password,
      required this.role});
  Map<String, dynamic> toJson() => {
        "email": email,
        "nama": nama,
        "telepon": telepon,
        "password": password,
        "role": role,
      };
  User from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      nama: snapshot['nama'],
      telepon: snapshot['telepon'],
      password: snapshot['password'],
      role: snapshot['role'],
    );
  }

  getUser(User user) {
    Map<String, dynamic> userData = {
      "email": email,
      "nama": user.nama,
      "telepon": user.telepon,
      "password": user.password,
      "role": user.role,
    };
  }

  addSPB(User user) {
    bool status = true;
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() async =>
              await fireStore.collection('users').doc().set(user.toJson()));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    Get.snackbar('Sukses', 'Sukses Memasukan data');
  }
}
