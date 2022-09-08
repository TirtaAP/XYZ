import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:xyz/entity/saribuahApel.dart';
import 'package:xyz/helper/constant.dart';

class BoxSariBuahApel {
  int? jumlah;
  int? isi;
  get getIsi => this.isi;

  set setIsi(isi) => this.isi = isi;
  int? harga;

  SaribuahApel? saribuahApel;
  SaribuahApel? get getSaribuahApel => this.saribuahApel;

  set setSaribuahApel(SaribuahApel? saribuahApel) =>
      this.saribuahApel = saribuahApel;

  get getJumlah => this.jumlah;

  set setJumlah(jumlah) => this.jumlah = jumlah;

  get getHarga => this.harga;

  set setHarga(harga) => this.harga = harga;

  BoxSariBuahApel({this.jumlah, this.harga, this.isi, this.saribuahApel});
  Map<String, dynamic> toJson() => {
        'saribuah': saribuahApel!.toJson(),
        'isi': isi,
        'harga': harga,
        'jumlah': jumlah
      };
  Future<BoxSariBuahApel> from(DocumentSnapshot snap) async {
    var snapshot = snap.data() as Map<String, dynamic>;

    return BoxSariBuahApel(
        jumlah: snapshot['jumlah'],
        harga: snapshot['harga'],
        saribuahApel: saribuahApel!.from(snapshot['saribuah']));
  }

  addSaribuahbox(BoxSariBuahApel boxSariBuahApel) async {
    try {
      fireStore.collection('box').add(boxSariBuahApel.toJson());
    } catch (e) {
      print(e);
    }
  }

  hapusBox(String docid) async {
    try {
      await fireStore.collection('box').doc(docid).delete();
    } catch (e) {
      Get.snackbar('Gagal Menghapus Data', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Hapus Data');
  }
}
