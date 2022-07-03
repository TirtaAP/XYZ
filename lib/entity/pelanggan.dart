import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Pelanggan {
  String nama;
  String contactperson;
  String telepon;
  String alamat;
  String provinsi;
  String kota;

  Pelanggan(
      {required this.nama,
      required this.contactperson,
      required this.telepon,
      required this.alamat,
      required this.provinsi,
      required this.kota});
  Map<String, dynamic> toJson() => {
        "nama": nama,
        "contactperson": contactperson,
        "telepon": telepon,
        "alamat": alamat,
        "provinsi": provinsi,
        "kota": kota
      };
  Pelanggan from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Pelanggan(
        nama: snapshot['nama'],
        contactperson: snapshot['contactperson'],
        telepon: snapshot['telepon'],
        alamat: snapshot['alamat'],
        provinsi: snapshot['provinsi'],
        kota: snapshot['kota']);
  }
}
