import 'package:flutter/material.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/controller/authcontroller.dart';
import 'package:xyz/view/login_page.dart';
import 'package:xyz/view/pelanggan_page.dart';
import 'package:xyz/view/penjualan_page.dart';
import 'package:xyz/view/pesanan_page.dart';
import 'package:xyz/view/saribuah_page.dart';
import 'package:xyz/view/spb_page.dart';
import 'package:xyz/view/stok_page.dart';
import 'package:xyz/widgets/headrawer.dart';
import 'package:xyz/widgets/sidenav.dart';
import 'package:get/get.dart';

class logut extends StatefulWidget {
  logut({Key? key}) : super(key: key);

  @override
  State<logut> createState() => _logutState();
}

class _logutState extends State<logut> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var out = authController.logout();
    Get.offAll(LoginScreen());
    return out;
  }
}
