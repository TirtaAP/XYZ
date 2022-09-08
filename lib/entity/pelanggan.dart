import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:xyz/helper/constant.dart';

class Pelanggan {
  String? nama;
  String? contactperson;
  String? telepon;
  String? alamat;
  String? provinsi;
  String? kota;
  get getNama => this.nama;

  set setNama(nama) => this.nama = nama;

  get getContactperson => this.contactperson;

  set setContactperson(contactperson) => this.contactperson = contactperson;

  get getTelepon => this.telepon;

  set setTelepon(telepon) => this.telepon = telepon;

  get getAlamat => this.alamat;

  set setAlamat(alamat) => this.alamat = alamat;

  get getProvinsi => this.provinsi;

  set setProvinsi(provinsi) => this.provinsi = provinsi;

  get getKota => this.kota;

  set setKota(kota) => this.kota = kota;

  Pelanggan(
      {this.nama,
      this.contactperson,
      this.telepon,
      this.alamat,
      this.provinsi,
      this.kota});
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

  addPelanggan(Pelanggan pelanggan) async {
    try {
      await fireStore
          .collection('pelanggan')
          .doc()
          .set(pelanggan.toJson())
          .whenComplete(() => print("Pelanggan item added to the database"));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Memasukan data');
  }

  updatePelanggan(String docid, Pelanggan pelanggan) async {
    try {
      await fireStore
          .collection('pelanggan')
          .doc(docid)
          .update(pelanggan.toJson());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Update Data');
  }

  HapusPelanggan(String docid) async {
    try {
      await fireStore.collection('pelanggan').doc(docid).delete();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Hapus Data');
  }

  getPelangganbyId() {}
}
