import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/view/saribuah_page.dart';
import 'package:xyz/view/pesanan_page.dart';
import 'package:xyz/view/pelanggan_page.dart';
import 'package:xyz/view/spb_page.dart';
import 'package:xyz/view/penjualan_page.dart';

List pages = [
  PesananPage(),
  barangPage(),
  spbPage(),
  pelangganPage(),
  penjualanPage()
];

enum Menu { edit, delete }

var fireStore = FirebaseFirestore.instance;
