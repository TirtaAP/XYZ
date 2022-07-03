import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/entity/user.dart' as model;

class UserController extends GetxController {
  AddSPB(String username, String nama, String telepon, String password,
      String confirmPass) async {
    try {
      if (username.isNotEmpty &&
          nama.isNotEmpty &&
          telepon.isNotEmpty &&
          password.isNotEmpty) {
        model.User user = model.User(
            username: username,
            nama: nama,
            telepon: telepon,
            password: password,
            level: "SPB");
        await fireStore
            .collection('users')
            .doc()
            .set(user.toJson())
            .whenComplete(() => print("user item added to the database"));
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
    CollectionReference notesItemCollection = fireStore.collection('users');

    return notesItemCollection.snapshots();
  }

  HapusSPB(String id) async {
    try {
      await fireStore.collection('users').doc(id).delete();
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar('Gagal Menghapus Data', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }
}
