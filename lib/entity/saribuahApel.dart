import 'package:xyz/entity/boxSariBuah.dart';
import 'package:xyz/entity/pelanggan.dart';

import 'komposisi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/helper/constant.dart';

class SaribuahApel {
  String? isiBersih;
  DateTime? tglProduksi;
  DateTime? tglKadaluarsa;
  List<dynamic>? komposisi;
  List<dynamic>? sertifikat;

  get getSertifikat => this.sertifikat;

  set setSertifikat(sertifikat) => this.sertifikat = sertifikat;

  get getIsiBersih => {"isiBersih": isiBersih};

  set setIsiBersih(String isiBersih) => this.isiBersih = isiBersih;

  get getTglProduksi => this.tglProduksi;

  set setTglProduksi(tglProduksi) => this.tglProduksi = tglProduksi;

  get getTglKadaluarsa => this.tglKadaluarsa;

  set setTglKadaluarsa(tglKadaluarsa) => this.tglKadaluarsa = tglKadaluarsa;

  get getKomposisi => this.komposisi;

  set setKomposisi(komposisi) => this.komposisi = komposisi;

  SaribuahApel(
      {this.isiBersih,
      this.tglProduksi,
      this.tglKadaluarsa,
      this.komposisi,
      this.sertifikat});
  Map<String, dynamic> toJson() => {
        "isiBersih": isiBersih,
        "tglProduksi": tglProduksi,
        "tglKadaluarsa": tglKadaluarsa,
        "komposisi": komposisi,
        "sertifikat": sertifikat
      };
  SaribuahApel from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SaribuahApel(
        isiBersih: snapshot['isiBersih'],
        komposisi: snapshot['komposisi'],
        sertifikat: snapshot['noSertifikat']);
  }

  SaribuahApel fromMap(DocumentSnapshot<Map<String, dynamic>> snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SaribuahApel(
        isiBersih: snapshot['isiBersih'],
        tglProduksi: snapshot['tglProduksi'],
        tglKadaluarsa: snapshot['tglKadaluarsa'],
        komposisi: snapshot['komposisi'],
        sertifikat: snapshot['noSertifikat']);
  }

  addSaribuah(SaribuahApel saribuahApel) async {
    var isSuccses;
    var error;
    var ref = fireStore.collection('saribuah').doc();
    var id = ref.id;
    try {
      ref.set(saribuahApel.toJson());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Update Data');
  }

  getSaribuah(String docid) {
    try {
      fireStore.collection('saribuah').doc(docid).snapshots();
    } catch (e) {
      print(e);
    }
  }

  addKomposisi(String docid, Komposisi komposisi) async {
    var obj = await fireStore.collection('saribuah').doc(docid).get();
    SaribuahApel saribuahApel = SaribuahApel().fromMap(obj);

    saribuahApel.komposisi!.add(komposisi.toJson());
    try {
      await fireStore
          .collection('saribuah')
          .doc(docid)
          .update(saribuahApel.toJson());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Memasukan data');
  }

  hapusSariBuah(String docid) async {
    try {
      await fireStore.collection('saribuah').doc(docid).delete();
    } catch (e) {
      Get.snackbar('Gagal Menghapus Data', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Hapus Data');
  }
}
