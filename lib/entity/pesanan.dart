import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/entity/boxSariBuah.dart';
import 'package:xyz/entity/pelanggan.dart';
import 'package:xyz/helper/constant.dart';
import 'package:get/get.dart';

class Pesanan {
  DocumentReference? pelanggan;
  DateTime? tanggal;
  DocumentReference? boxSariBuahApel;
  int? harga;
  int? jumlah;
  String? status;
  String? oleh;

  get getPelanggan => this.pelanggan;

  set setPelanggan(pelanggan) => this.pelanggan = pelanggan;

  get getTanggal => this.tanggal;

  set setTanggal(tanggal) => this.tanggal = tanggal;

  get getBoxSariBuahApel => this.boxSariBuahApel;

  set setBoxSariBuahApel(boxSariBuahApel) =>
      this.boxSariBuahApel = boxSariBuahApel;

  get getHarga => this.harga;

  set setHarga(harga) => this.harga = harga;

  get getJumlah => this.jumlah;

  set setJumlah(jumlah) => this.jumlah = jumlah;

  get getStatus => this.status;

  set setStatus(status) => this.status = status;

  get getOleh => this.oleh;

  set setOleh(oleh) => this.oleh = oleh;

  Pesanan({
    this.pelanggan,
    this.tanggal,
    this.boxSariBuahApel,
    this.harga,
    this.jumlah,
    this.status,
    this.oleh,
  });
  Map<String, dynamic> toJson() => {
        "pelanggan": pelanggan,
        "tanggal": tanggal,
        "boxsaribuah": boxSariBuahApel,
        "harga": harga,
        "jumlah": jumlah,
        "status": status,
        "oleh": oleh
      };
  Pesanan from(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Pesanan(
        pelanggan: snapshot['pelanggan'],
        tanggal: snapshot['tanggal'],
        boxSariBuahApel: snapshot['Boxsaribuah'],
        harga: snapshot['harga'],
        jumlah: snapshot['jumlah'],
        status: snapshot['status'],
        oleh: snapshot['oleh']);
  }

  addPesanan(Pesanan pesanan) async {
    var isSuccses;
    var error;
    var ref = fireStore.collection('pesanan').doc();
    try {
      await ref.set(pesanan.toJson());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Memasukan data');
  }

  hapusPesanan(String docid) async {
    try {
      await fireStore.collection('pesanan').doc(docid).delete();
    } catch (e) {
      Get.snackbar('Gagal Menghapus Data', e.toString());
    }
    Get.snackbar('Berhasil', 'Sukses Hapus Data');
  }

  totalpenjualan() async {
    num sum = 0;
    var sa = await fireStore
        .collection('pesanan')
        .where('status', isEqualTo: 'Draft')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        num val = element.data()['harga'];
        sum = sum + val;
      });
      return sum;
    });
    return sa;
  }
}
