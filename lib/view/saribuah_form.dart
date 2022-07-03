import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';
import 'package:xyz/helper/format_changer.dart';

class BarangForm extends StatefulWidget {
  BarangForm({Key? key}) : super(key: key);

  @override
  State<BarangForm> createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
  final TextEditingController _tanggalproduksi = TextEditingController();
  final TextEditingController _gelombang = TextEditingController();
  final TextEditingController _biaya = TextEditingController();
  final TextEditingController _jumlah = TextEditingController();
  final sariBuahController saribuahController = Get.put(sariBuahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('barangform'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _tanggalproduksi,
              readOnly: true,
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now())
                    .then((value) {
                  _tanggalproduksi.text = FormatChanger().tanggalIndo(value!);
                });
              },
              decoration: InputDecoration(
                labelText: 'Tanggal',
                icon: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Icon(Icons.calendar_month),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _gelombang,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], //
              decoration: InputDecoration(
                labelText: 'Gelombang',
                icon: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Icon(Icons.monetization_on),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _biaya,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], //
              decoration: InputDecoration(
                labelText: 'Biaya',
                icon: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Icon(Icons.monetization_on),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _jumlah,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], //
              decoration: InputDecoration(
                labelText: 'Jumlah',
                icon: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Icon(Icons.monetization_on),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () => saribuahController.addSariBuah(
                      _tanggalproduksi.text,
                      _gelombang.text,
                      int.parse(_biaya.text),
                      int.parse(_jumlah.text)),
                  child: Text('Simpan')),
            )
          ],
        ),
      ),
    );
  }
}
