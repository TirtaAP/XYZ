import 'package:flutter/material.dart';

class penjualanPage extends StatefulWidget {
  penjualanPage({Key? key}) : super(key: key);

  @override
  State<penjualanPage> createState() => _penjualanPageState();
}

class _penjualanPageState extends State<penjualanPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('PenjualanPage')),
    );
  }
}
