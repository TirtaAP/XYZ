import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class User {
  String username;
  String nama;
  String telepon;
  String password;
  String level;

  User(
      {required this.username,
      required this.nama,
      required this.telepon,
      required this.password,
      required this.level});
  Map<String, dynamic> toJson() => {
        "username": username,
        "nama": nama,
        "telepon": telepon,
        "password": password,
        "level": level,
      };
  User from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      nama: snapshot['nama'],
      telepon: snapshot['telepon'],
      password: snapshot['password'],
      level: snapshot['level'],
    );
  }
}
