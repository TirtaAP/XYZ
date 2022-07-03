import 'package:get/get.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/entity/saribuahApel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class sariBuahController extends GetxController {
  addSariBuah(String kodeproduksi, String nama, int harga, int jumlah) async {
    try {
      if (kodeproduksi.isNotEmpty && nama.isNotEmpty) {
        Saribuah saribuah =
            Saribuah(kodeproduksi: kodeproduksi, hargaMin: harga);
        await fireStore
            .collection('barang')
            .doc()
            .set(saribuah.toJson())
            .whenComplete(() => print("Data berhasil disimpan"));
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

  Stream<QuerySnapshot> GetAllBarang() {
    CollectionReference notesItemCollection = fireStore.collection('barang');

    return notesItemCollection.snapshots();
  }

  hapusSariBuah(String id) async {
    try {
      await fireStore.collection('barang').doc(id).delete();
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar('Gagal Menghapus Data', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }
}
