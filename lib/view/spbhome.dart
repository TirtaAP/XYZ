import 'package:flutter/material.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/controller/authcontroller.dart';
import 'package:xyz/view/pelanggan_page.dart';
import 'package:xyz/view/penjualan_page.dart';
import 'package:xyz/view/pesanan_page.dart';
import 'package:xyz/view/saribuah_page.dart';
import 'package:xyz/view/spb_page.dart';
import 'package:xyz/view/stok_page.dart';
import 'package:xyz/widgets/headrawer.dart';
import 'package:xyz/widgets/sidenav.dart';

class spbHome extends StatefulWidget {
  spbHome({Key? key}) : super(key: key);

  @override
  State<spbHome> createState() => _spbHomeState();
}

class _spbHomeState extends State<spbHome> {
  var currentPage = DrawerSections.penjualan;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.penjualan) {
      container = penjualanPage();
    } else if (currentPage == DrawerSections.pesanan) {
      container = PesananPage();
    } else if (currentPage == DrawerSections.pelanggan) {
      container = pelangganPage();
    } else if (currentPage == DrawerSections.spb) {
      container = spbPage();
    } else if (currentPage == DrawerSections.saribuah) {
      container = SariBuahPage();
    } else if (currentPage == DrawerSections.stok) {
      container = stockPage();
    } else if (currentPage == DrawerSections.privacy_policy) {
      container = AuthController().logout();
    } else if (currentPage == DrawerSections.send_feedback) {
      container = () {};
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("UMKM XYZ"),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.penjualan ? true : false),
          menuItem(2, "Pesanan", Icons.inbox,
              currentPage == DrawerSections.pesanan ? true : false),
          menuItem(3, "Pelanggan", Icons.people_alt_outlined,
              currentPage == DrawerSections.pelanggan ? true : false),
          menuItem(4, "SPB", Icons.local_offer,
              currentPage == DrawerSections.spb ? true : false),
          Divider(),
          menuItem(5, "Stok", Icons.settings_outlined,
              currentPage == DrawerSections.stok ? true : false),
          menuItem(6, "Saribuah", Icons.notifications_outlined,
              currentPage == DrawerSections.saribuah ? true : false),
          Divider(),
          menuItem(7, "Logout", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.penjualan;
            } else if (id == 2) {
              currentPage = DrawerSections.pesanan;
            } else if (id == 3) {
              currentPage = DrawerSections.pelanggan;
            } else if (id == 4) {
              currentPage = DrawerSections.spb;
            } else if (id == 5) {
              currentPage = DrawerSections.stok;
            } else if (id == 6) {
              currentPage = DrawerSections.saribuah;
            } else if (id == 7) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 8) {
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  penjualan,
  pesanan,
  spb,
  stok,
  saribuah,
  pelanggan,
  privacy_policy,
  send_feedback,
}
