import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/view/admin_page.dart';
import 'package:xyz/view/login_page.dart';
import 'package:xyz/view/pesanan_form.dart';
import 'package:xyz/view/spb_form.dart';

class AuthController extends GetxController {
  login(BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      AlertDialog alert = AlertDialog(
        title: Text("Login Failed"),
        content: Container(
          child: Text(getMessageFromErrorCode(e.code)),
        ),
        actions: [
          TextButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );

      showDialog(context: context, builder: (context) => alert);
      return;
    }
    auth.userChanges();
    roleCheck();
  }

  roleCheck() async {
    var email = auth.currentUser!.email;
    var querysnap = fireStore
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs.single.data());
    var data = await querysnap;
    var roles = data['role'];

    print(roles);

    if (roles == 'ADMIN') {
      Get.offAll(() => adminHome());
    } else if (roles == "SPB") {
      Get.offAll(() => SpbForm());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  getUser() {
    var email = auth.currentUser!.email;
    String emails = email.toString();
    return emails;
  }

  logout() {
    auth.signOut();
    auth.userChanges();
    Get.offAll(() => LoginScreen());
  }
}
