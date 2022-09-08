import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/entity/pelanggan.dart';

class PelangganController extends GetxController {
  final Rx<List<Pelanggan>> pelangganList = Rx<List<Pelanggan>>([]);
  List<Pelanggan> get pelanggans => pelangganList.value;
  Pelanggan pelanggan = new Pelanggan();

  addPelanggan(BuildContext context, String nama, String contactperson,
      String telepon, String alamat, String provinsi, String kota) {
    Pelanggan pelanggan = Pelanggan(
        nama: nama,
        contactperson: contactperson,
        telepon: telepon,
        alamat: alamat,
        provinsi: provinsi,
        kota: kota);
    pelanggan.addPelanggan(pelanggan);
    Navigator.pop(context);
  }

  updatePelanggan(
      BuildContext context,
      String docid,
      String nama,
      String contactperson,
      String telepon,
      String alamat,
      String provinsi,
      String kota) {
    Pelanggan pelanggan = Pelanggan(
        nama: nama,
        contactperson: contactperson,
        telepon: telepon,
        alamat: alamat,
        provinsi: provinsi,
        kota: kota);

    pelanggan.updatePelanggan(docid, pelanggan);
    Navigator.pop(context);
  }

  hapusPelanggan(BuildContext context, String docid) {
    pelanggan.HapusPelanggan(docid);
    Get.back();
    //Navigator.pop(context);
  }

  static Stream<QuerySnapshot> GetAllpelanggan() {
    CollectionReference notesItemCollection = fireStore.collection('pelanggan');

    return notesItemCollection.snapshots();
  }
}
