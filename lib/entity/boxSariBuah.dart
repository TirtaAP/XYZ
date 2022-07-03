import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class boxSariBuahApel {
  int jumlah;
  int harga;
  String barcode;
  boxSariBuahApel(
      {required this.jumlah, required this.harga, required this.barcode});
  Map<String, dynamic> toJson() => {};
  boxSariBuahApel from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return boxSariBuahApel(
        jumlah: snapshot['jumlah'],
        harga: snapshot['harga'],
        barcode: snapshot['barcode']);
  }
}
