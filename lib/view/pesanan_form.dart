import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/pelanggancontroller.dart';
import 'package:xyz/helper/format_changer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/controller/pesanancontroller.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';

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
  var carMake, carMakeModel, carMake1;
  var setDefaultMake = true,
      setDefaultMakeModel = true,
      setDefaultMake1 = true,
      setDefaultMakeModel1 = true;

  String user = "user";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Pesananform'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: PelangganController.GetAllpelanggan(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // Safety check to ensure that snapshot contains data
                // without this safety check, StreamBuilder dirty state warnings will be thrown
                if (!snapshot.hasData) return Container();
                // Set this value for default,
                // setDefault will change if an item was selected
                // First item from the List will be displayed
                if (setDefaultMake) {
                  carMake = snapshot.data!.docs[0].get('nama');
                  debugPrint('setDefault make: $carMake');
                }
                return DropdownButtonFormField(
                  decoration: const InputDecoration(
                      icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.people))),
                  isExpanded: true,
                  value: carMake,
                  items: snapshot.data!.docs.map((value) {
                    return DropdownMenuItem(
                      value: value.get('nama'),
                      child: Text('${value.get('nama')}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _pilihanPelanggan = value.toString();
                    });
                  },
                );
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('barang')
                  .orderBy('tanggal')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // Safety check to ensure that snapshot contains data
                // without this safety check, StreamBuilder dirty state warnings will be thrown
                if (!snapshot.hasData) return Container();
                // Set this value for default,
                // setDefault will change if an item was selected
                // First item from the List will be displayed
                if (setDefaultMake1) {
                  carMake = snapshot.data!.docs[0].get('tanggal');
                  debugPrint('setDefault make: $carMake1');
                }
                return DropdownButtonFormField(
                  decoration: const InputDecoration(
                      icon: Padding(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Icon(Icons.category))),
                  isExpanded: true,
                  value: carMake1,
                  items: snapshot.data!.docs.map((value) {
                    return DropdownMenuItem(
                      value: value.get('tanggal'),
                      child: Text('${value.get('tanggal')}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _pilihanBarang = value.toString();
                    });
                  },
                );
              },
            ),
            TextField(
              controller: _tanggal,
              readOnly: true,
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now())
                    .then((value) {
                  _tanggal.text = FormatChanger().tanggalIndo(value!);
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
            TextField(
              controller: _jumlah,
              keyboardType: TextInputType.number,
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
            TextField(
              controller: _harga,
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
                onPressed: () => pesanancontroller.registerPesanan(
                    _pilihanPelanggan,
                    _tanggal.text,
                    _pilihanBarang,
                    _jumlah.text,
                    _harga.text,
                    _pilihanStatus,
                    user),
                child: Text('Simpan'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
