import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Pesanan {
  String pelanggan;
  int tanggal;
  String barang;
  int jumlah;
  int harga;
  String status;
  String oleh;
  Pesanan({
    required this.pelanggan,
    required this.tanggal,
    required this.barang,
    required this.jumlah,
    required this.harga,
    required this.status,
    required this.oleh,
  });
  Map<String, dynamic> toJson() => {
        "pelanggan": pelanggan,
        "tanggal": tanggal,
        "barang": barang,
        "jumlah": jumlah,
        "harga": harga
      };
  Pesanan from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Pesanan(
        pelanggan: snapshot['pelanggan'],
        tanggal: snapshot['tanggal'],
        barang: snapshot['barang'],
        jumlah: snapshot[' jumlah'],
        harga: snapshot['harga'],
        status: snapshot['status'],
        oleh: snapshot['oleh']);
  }
}
