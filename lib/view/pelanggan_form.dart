import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/widgets/text_field_input.dart';
import 'package:xyz/controller/pelanggancontroller.dart';

class PelangganForm extends StatefulWidget {
  PelangganForm({Key? key}) : super(key: key);

  @override
  State<PelangganForm> createState() => _PelangganFormState();
}

class _PelangganFormState extends State<PelangganForm> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _telepon = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _provinsi = TextEditingController();
  final TextEditingController _kota = TextEditingController();
  final TextEditingController _contactperson = TextEditingController();
  final PelangganController pelanggancontroller =
      Get.put(PelangganController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('pelangganform'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
                controller: _nama, labelText: 'Nama', icon: Icons.people),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
                controller: _contactperson,
                labelText: 'Contact Person',
                icon: Icons.contact_mail),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
                controller: _telepon, labelText: 'Telepon', icon: Icons.phone),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
                controller: _provinsi,
                labelText: 'Provinsi',
                icon: Icons.area_chart_outlined),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
                controller: _kota,
                labelText: 'Kota',
                icon: Icons.location_city),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
                controller: _alamat, labelText: 'Alamat', icon: Icons.pin_drop),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () => pelanggancontroller.registerPelanggan(
                      _nama.text,
                      _contactperson.text,
                      _telepon.text,
                      _alamat.text,
                      _provinsi.text,
                      _kota.text),
                  child: Text('Simpan')),
            )
          ],
        ),
      ),
    );
  }
}
