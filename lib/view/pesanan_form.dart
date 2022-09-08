import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/pelanggancontroller.dart';
import 'package:xyz/helper/format_changer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/controller/pesanancontroller.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';
import 'package:intl/intl.dart';
import 'package:xyz/helper/constant.dart';

class PesananForm extends StatefulWidget {
  PesananForm({Key? key}) : super(key: key);

  @override
  State<PesananForm> createState() => _PesananFormState();
}

class _PesananFormState extends State<PesananForm> {
  String _pilihanPelanggan = "",
      _pilihanStatus = "- PILIH -",
      _pilihanBarang = "";
  final TextEditingController _tanggal = TextEditingController();
  final TextEditingController _jumlah = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final PesananController pesanancontroller = Get.put(PesananController());
  final sariBuahController saribuahController = Get.put(sariBuahController());
  final List<String> _status = ["- PILIH -", "Draft", "Pembayaran", "Selesai"];
  final _formKey = GlobalKey<FormState>();
  late DateTime date;
  var pilihanSaribuah;

  var pelangganN = Get.arguments[2];
  var pelangganP = Get.arguments[1];
  bool edit = false;

  String user = "user";

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      pesanancontroller.addPesanan(
          pelangganP,
          pilihanSaribuah,
          date,
          int.parse(_jumlah.text),
          int.parse(_harga.text),
          _pilihanStatus,
          auth.currentUser!.email!);
    }
  }

  @override
  void initState() {
    super.initState();

    if (Get.arguments[0] == true) {
      edit = true;
      pelangganN = Get.arguments[1];
      _tanggal.text = Get.arguments[2];
      _pilihanBarang = Get.arguments[3];
      _jumlah.text = Get.arguments[4];
      _harga.text = Get.arguments[5];
      _pilihanStatus = Get.arguments[6];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Pesananform'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text('Pelanggan  '),
                    Text(pelangganN),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: fireStore.collection('box').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) return const Text('Loading...');
                      return Container(
                        child: DropdownButton(
                          value: pilihanSaribuah,
                          isDense: true,
                          hint: Text('Pilih Produk Sari Buah'),
                          items: snapshot.data!.docs.map((value) {
                            return DropdownMenuItem(
                              value: value.id,
                              child: Row(
                                children: [
                                  Text(
                                      value['saribuah']['isiBersih'] + '     '),
                                  Text(DateFormat.yMd().format(
                                      (value['saribuah']['tglKadaluarsa']
                                              as Timestamp)
                                          .toDate()))
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              pilihanSaribuah = value;
                            });
                          },
                        ),
                      );
                    }),
                TextFormField(
                  controller: _tanggal,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mohon Masukan Data';
                    }
                    return null;
                  },
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000))
                        .then((value) {
                      _tanggal.text = FormatChanger().tanggalIndo(value!);
                      date = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tanggal',
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _jumlah,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mohon Masukan Data';
                    }
                    return null;
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], //
                  decoration: const InputDecoration(
                    labelText: 'Jumlah',
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.numbers),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _harga,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mohon Masukan Data';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], //
                  decoration: const InputDecoration(
                    labelText: 'Total Harga',
                    icon: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Icon(Icons.monetization_on),
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.category_outlined))),
                  isExpanded: true,
                  items: _status.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _pilihanStatus = value.toString();
                    });
                  },
                  value: _pilihanStatus,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () => _trySubmitForm(), child: Text('Simpan')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
