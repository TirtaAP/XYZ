import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/entity/boxSariBuah.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/entity/saribuahApel.dart';
import 'package:xyz/entity/komposisi.dart';
import 'package:xyz/entity/sertifikat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class sariBuahController extends GetxController {
  SaribuahApel saribuahApel = new SaribuahApel();
  addSariBuah(
    BuildContext context,
    String isiBersih,
    DateTime tglProduksi,
    DateTime tglKadaluarsa,
    String harga,
    String jumlah,
  ) async {
    var har = int.parse(harga);
    var jum = int.parse(jumlah);
    SaribuahApel saribuah = SaribuahApel(
      isiBersih: isiBersih,
      tglProduksi: tglProduksi,
      tglKadaluarsa: tglKadaluarsa,
      komposisi: Kompos,
      sertifikat: Serti,
    );

    Navigator.pop(context);
  }

  hapusSaribuah(String docid) {
    saribuahApel.hapusSariBuah(docid);
    Get.back();
  }

  addKomposisi(String docid, String nama, String kandungan) {
    Komposisi komposisi = new Komposisi(nama: nama, kandungan: kandungan);
    SaribuahApel saribuahApel = new SaribuahApel();
    saribuahApel.addKomposisi(docid, komposisi);
  }

  Stream<QuerySnapshot> GetAllSaribuah() {
    CollectionReference notesItemCollection = fireStore.collection('saribuah');

    return notesItemCollection.snapshots();
  }

  addStoksaribuah(String docid, DateTime tanggalKadaluarsa,
      DateTime tanggalProduksi, int isJumlah, int harga, int stok) async {
    var ref = await fireStore.collection('saribuah').doc(docid).get();
    SaribuahApel saribuahApel = new SaribuahApel();

    saribuahApel.setIsiBersih = ref['isiBersih'];
    saribuahApel.setKomposisi = ref['komposisi'];
    saribuahApel.setSertifikat = ref['sertifikat'];
    saribuahApel.setTglKadaluarsa = tanggalKadaluarsa;
    saribuahApel.setTglProduksi = tanggalProduksi;
    BoxSariBuahApel boxSariBuahApel = BoxSariBuahApel(
        jumlah: stok, harga: harga, isi: isJumlah, saribuahApel: saribuahApel);
    boxSariBuahApel.addSaribuahbox(boxSariBuahApel);
  }

  hapusStokSaribuah(String docid) {
    BoxSariBuahApel boxSariBuahApel = BoxSariBuahApel();

    boxSariBuahApel.hapusBox(docid);
  }
}
