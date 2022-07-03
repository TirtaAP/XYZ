import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

//spesifik
class SaribuahApel {
  String isiBersih;
  int tglProduksi;
  int tglKadaluarsa;
  String barcode;
  List komposisi;
  List noSertifikat;

  SaribuahApel(
      {required this.isiBersih,
      required this.tglProduksi,
      required this.tglKadaluarsa,
      required this.barcode,
      required this.komposisi,
      required this.noSertifikat});
  Map<String, dynamic> toJson() => {};
  SaribuahApel from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SaribuahApel(
        isiBersih: snapshot['isiBersih'],
        tglProduksi: snapshot['tglProduksi'],
        tglKadaluarsa: snapshot['tglKadaluarsa'],
        barcode: snapshot['barcode'],
        komposisi: snapshot['komposisi'],
        noSertifikat: snapshot['noSertifikat']);
  }
}
