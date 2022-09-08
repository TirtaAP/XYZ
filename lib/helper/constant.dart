import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/view/saribuah_page.dart';
import 'package:xyz/view/pesanan_page.dart';
import 'package:xyz/view/pelanggan_page.dart';
import 'package:xyz/view/spb_page.dart';
import 'package:xyz/view/penjualan_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

List pages = [
  PesananPage(),
  SariBuahPage(),
  spbPage(),
  pelangganPage(),
  penjualanPage()
];

List<Map<String, dynamic>> Kompos = [
  {'nama': 'Apel', 'kandungan': '20 gr'}
];

List<Map<String, dynamic>> Serti = [
  {'lembaga': 'MUI', 'noSertifikat': '121212121'}
];

enum Menu { edit, delete }

enum PelangganM { edit, delete, pesan }

enum Sarbu { edit, delete, komposisi, sertifikat }

enum Stok { pesan, edit, delete }

var fireStore = FirebaseFirestore.instance;
var auth = FirebaseAuth.instance;

String getMessageFromErrorCode(String? errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
      break;
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
      break;
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
      break;
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
      break;
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
    case "operation-not-allowed":
      return "Server error, please try again later.";
      break;
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
      break;
    default:
      return "Login failed. Please try again.";
      break;
  }
}
