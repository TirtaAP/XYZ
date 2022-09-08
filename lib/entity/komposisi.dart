import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/helper/constant.dart';

class Komposisi {
  String? nama;
  String? kandungan;

  get getNama => this.nama;

  set setNama(String nama) => this.nama = nama;

  get getKandungan => this.kandungan;

  set setKandungan(kandungan) => this.kandungan = kandungan;

  Komposisi({this.nama, this.kandungan});

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "kandungan": kandungan,
      };
}
