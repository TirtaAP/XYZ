import 'package:flutter/material.dart';
import 'package:xyz/helper/constant.dart';

class adminHome extends StatefulWidget {
  adminHome({Key? key}) : super(key: key);

  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text('user'),
        actions: [
          IconButton(onPressed: (() {}), icon: Icon(Icons.power_settings_new))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: pageIdx,
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'INVOICE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'BARANG',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt),
            label: 'SPB',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'PELANGGAN',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.align_vertical_bottom_rounded),
            label: 'PENJUALAN',
          )
        ],
      ),
      body: pages[pageIdx],
    );
  }
}
