import 'package:get/get.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/entity/pesanan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PesananController extends GetxController {
  registerPesanan(String pelanggan, String tanggal, String barang,
      String jumlah, String harga, String status, String oleh) async {
    try {
      if (tanggal.isNotEmpty &&
          barang.isNotEmpty &&
          jumlah.isNotEmpty &&
          harga.isNotEmpty) {
        Pesanan pesanan = Pesanan(
            pelanggan: pelanggan,
            tanggal: tanggal,
            barang: barang,
            jumlah: jumlah,
            harga: harga,
            status: status,
            oleh: oleh);
        await fireStore
            .collection('pesanan')
            .doc()
            .set(pesanan.toJson())
            .whenComplete(() => print("Notes item added to the database"));
      } else {
        Get.snackbar('Error Input', 'Mohon Lengkapi Data Anda',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar('Gagal Memasukan Data', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }

  Stream<QuerySnapshot> GetAllpesanan() {
    CollectionReference notesItemCollection = fireStore.collection('pesanan');

    return notesItemCollection.snapshots();
  }

  HapusPesanan(String id) async {
    try {
      await fireStore.collection('pesanan').doc(id).delete();
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar('Gagal Menghapus Data', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }
}
