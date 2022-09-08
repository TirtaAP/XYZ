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
  final _formKey = GlobalKey<FormState>();
  late String docid;

  bool edit = false;
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      if (Get.arguments[0] == true) {
        pelanggancontroller.updatePelanggan(
            context,
            docid,
            _nama.text,
            _contactperson.text,
            _telepon.text,
            _alamat.text,
            _provinsi.text,
            _kota.text);
      } else {
        pelanggancontroller.addPelanggan(
            context,
            _nama.text,
            _contactperson.text,
            _telepon.text,
            _alamat.text,
            _provinsi.text,
            _kota.text);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (Get.arguments[0] == true) {
      edit = true;
      docid = Get.arguments[1];
      _nama.text = Get.arguments[2];
      _telepon.text = Get.arguments[3];
      _alamat.text = Get.arguments[4];
      _provinsi.text = Get.arguments[5];
      _kota.text = Get.arguments[6];
      _contactperson.text = Get.arguments[7];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: edit
            ? const Text('Edit Pelanggan')
            : const Text('Tambah Pelanggan'),
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
                    TextFormField(
                      controller: _nama,
                      decoration: const InputDecoration(labelText: 'Nama'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _telepon,
                      decoration: const InputDecoration(labelText: 'Telepon'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _alamat,
                      decoration: const InputDecoration(labelText: 'Alamat'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _provinsi,
                      decoration: const InputDecoration(labelText: 'Provinsi'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _kota,
                      decoration: const InputDecoration(labelText: 'Kota'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _contactperson,
                      decoration:
                          const InputDecoration(labelText: 'Contact Person'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Lengkapi Data';
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
