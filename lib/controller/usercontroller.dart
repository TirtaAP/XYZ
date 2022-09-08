import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/helper/dialog_helper.dart';
import 'package:xyz/entity/user.dart';
import 'package:xyz/view/admin_page.dart';

class UserController extends GetxController {
  AddSPB(
    BuildContext context,
    String email,
    String nama,
    String telepon,
    String password,
  ) async {
    User user = User(
        email: email,
        nama: nama,
        telepon: telepon,
        password: password,
        role: "SPB");
    user.addSPB(user);
    Navigator.pop(context);
  }

  static Stream<QuerySnapshot> GetAllUser() {
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
