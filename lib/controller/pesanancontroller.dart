import 'dart:ffi';

import 'package:get/get.dart';
import 'package:xyz/entity/boxSariBuah.dart';
import 'package:xyz/entity/pelanggan.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/entity/pesanan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/view/admin_page.dart';

class PesananController extends GetxController {
  List<Pesanan> pesananList = [];

  addPesanan(String pelanggan, String saribuah, DateTime tanggal, int jumlah,
      int harga, String status, String oleh) async {
    DocumentReference docrefSBA = fireStore.doc(saribuah);
    DocumentReference docrefP = fireStore.doc(pelanggan);
    Pesanan pesanan = Pesanan(
        pelanggan: docrefP,
        tanggal: tanggal,
        boxSariBuahApel: docrefSBA,
        harga: harga,
        jumlah: jumlah,
        status: status,
        oleh: oleh);
    pesanan.addPesanan(pesanan);
    Get.offAll(adminHome());
  }

  HapusPesanan(String docid) {
    Pesanan pesanan = Pesanan();
    pesanan.hapusPesanan(docid);
    Get.back();
  }

  totalPesanan() {
    Pesanan pesanan = Pesanan();
    var a = pesanan.totalpenjualan();

    return a;
  }

  docReftoDocSnap(String path) async {
    DocumentSnapshot a = await fireStore.doc(path).get();

    return a;
  }
}
