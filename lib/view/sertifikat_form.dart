import 'package:flutter/material.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';
import 'package:xyz/entity/komposisi.dart';
import 'package:get/get.dart';

class SertifikatForm extends StatefulWidget {
  SertifikatForm({Key? key}) : super(key: key);

  @override
  State<SertifikatForm> createState() => _SertifikatFormState();
}

class _SertifikatFormState extends State<SertifikatForm> {
  final TextEditingController lembaga = TextEditingController();
  final TextEditingController nomorSertifikat = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final sariBuahController saribuahController = Get.put(sariBuahController());
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      saribuahController.addKomposisi(
          Get.arguments[0], lembaga.text, nomorSertifikat.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah Sertifikat'),
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
                      controller: lembaga,
                      decoration:
                          const InputDecoration(labelText: 'Nama Lembaga'),
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
                    TextFormField(
                      controller: nomorSertifikat,
                      decoration:
                          const InputDecoration(labelText: 'Kode Sertifikat'),
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
