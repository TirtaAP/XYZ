import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/pesanancontroller.dart';
import 'package:intl/intl.dart';

class penjualanPage extends StatefulWidget {
  penjualanPage({Key? key}) : super(key: key);

  @override
  State<penjualanPage> createState() => _penjualanPageState();
}

class _penjualanPageState extends State<penjualanPage> {
  final PesananController pesanancontroller = Get.put(PesananController());
  final formatCurrency = new NumberFormat.currency(locale: 'ID');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Card(
                borderOnForeground: true,
                child: Column(
                  children: [
                    Text(
                      'Total Penjualan',
                      style: TextStyle(fontSize: 20),
                    ),
                    FutureBuilder(
                      future: pesanancontroller.totalPesanan(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Text(formatCurrency.format(snapshot.data));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 25,
              ),
              Text('Total Jumlah Pesanan'),
              SizedBox(
                height: 25,
              ),
              Text('Total Draft Pesanan'),
              Text('Total Proses Pembayaran')
            ],
          ),
        ],
      ),
    ));
  }
}
