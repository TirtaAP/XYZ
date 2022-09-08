import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';
import 'package:xyz/helper/constant.dart';
import 'package:intl/intl.dart';

class StokForm extends StatefulWidget {
  StokForm({Key? key}) : super(key: key);

  @override
  State<StokForm> createState() => _StokFormState();
}

class _StokFormState extends State<StokForm> {
  final TextEditingController _tanggalProduksi = TextEditingController();
  final TextEditingController _tanggalKadaluarsa = TextEditingController();
  final TextEditingController _isiJumlah = TextEditingController();
  final TextEditingController _totalStok = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final sariBuahController saribuahController = Get.put(sariBuahController());
  final _formKey = GlobalKey<FormState>();
  DateTime? tanggalKadaluarasa = DateTime.now();
  DateTime? tanggalProduksi = DateTime.now();

  var _mySelection;

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      int isJumlah = int.parse(_isiJumlah.text);
      int harga = int.parse(_harga.text);
      int jumlah = int.parse(_totalStok.text);
      saribuahController.addStoksaribuah(_mySelection, tanggalKadaluarasa!,
          tanggalProduksi!, isJumlah, harga, jumlah);

      print(_mySelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah Sari Buah'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: fireStore
                            .collection('saribuah')
                            .orderBy('isiBersih')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return const Text('Loading...');
                          return Container(
                            child: DropdownButton(
                              value: _mySelection,
                              isDense: true,
                              hint: Text('Pilih Produk Sari Buah'),
                              items: snapshot.data!.docs.map((value) {
                                return DropdownMenuItem(
                                  value: value.id,
                                  child: Text('${value.get('isiBersih')}'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _mySelection = value;
                                });
                              },
                            ),
                          );
                        }),
                    TextFormField(
                      controller: _tanggalProduksi,
                      decoration:
                          const InputDecoration(labelText: 'Tanggal Produksi'),
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000))
                            .then((value) {
                          _tanggalProduksi.text = value.toString();
                          tanggalProduksi = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _tanggalKadaluarsa,
                      decoration: const InputDecoration(
                          labelText: 'Tanggal Kadaluarsa'),
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000))
                            .then((value) {
                          _tanggalKadaluarsa.text = value.toString();
                          tanggalKadaluarasa = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _isiJumlah,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], //
                      decoration: const InputDecoration(
                        labelText: 'Isi Jumlah',
                        icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.numbers),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _totalStok,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], //
                      decoration: const InputDecoration(
                        labelText: 'Stok',
                        icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.numbers),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _harga,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], //
                      decoration: const InputDecoration(
                        labelText: 'Harga',
                        icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.numbers),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Data';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          onPressed: () => _trySubmitForm(),
                          child: const Text('Simpan')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
