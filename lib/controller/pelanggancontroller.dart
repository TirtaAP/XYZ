import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/entity/pelanggan.dart';

class PelangganController extends GetxController {
  final Rx<List<Pelanggan>> pelangganList = Rx<List<Pelanggan>>([]);
  List<Pelanggan> get pelanggans => pelangganList.value;

  registerPelanggan(String nama, String contactperson, String telepon,
      String alamat, String provinsi, String kota) async {
    try {
      if (nama.isNotEmpty &&
          contactperson.isNotEmpty &&
          telepon.isNotEmpty &&
          alamat.isNotEmpty &&
          provinsi.isNotEmpty &&
          kota.isNotEmpty) {
        Pelanggan pelanggan = Pelanggan(
            nama: nama,
            contactperson: contactperson,
            telepon: telepon,
            alamat: alamat,
            provinsi: provinsi,
            kota: kota);
        await fireStore
            .collection('pelanggan')
            .doc()
            .set(pelanggan.toJson())
            .whenComplete(() => print("Pelanggan item added to the database"));
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

  static Stream<QuerySnapshot> GetAllpelanggan() {
    CollectionReference notesItemCollection = fireStore.collection('pelanggan');

    return notesItemCollection.snapshots();
  }

  HapusPelanggan(String id) async {
    try {
      await fireStore.collection('pelanggan').doc(id).delete();
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar('Gagal Menghapus Data', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }
}
