import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Penjualan {
  String bulan;
  String tahun;
  int totalSariBuah;
  int totalBiaya;
  int totalHarga;

  Penjualan(
      {required this.bulan,
      required this.tahun,
      required this.totalSariBuah,
      required this.totalBiaya,
      required this.totalHarga});
  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "tahun": tahun,
        "totalSariBuah": totalSariBuah,
        "totalBiaya": totalBiaya,
        "totalHarga": totalHarga
      };
  Penjualan from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Penjualan(
      bulan: snapshot['nama'],
      tahun: snapshot['contactperson'],
      totalSariBuah: snapshot['telepon'],
      totalBiaya: snapshot['alamat'],
      totalHarga: snapshot['provinsi'],
    );
  }
}
