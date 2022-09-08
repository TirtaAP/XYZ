import 'package:flutter/material.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';
import 'package:xyz/entity/komposisi.dart';
import 'package:get/get.dart';

class komposisiForm extends StatefulWidget {
  komposisiForm({Key? key}) : super(key: key);
  @override
  State<komposisiForm> createState() => _komposisiFormState();
}

class _komposisiFormState extends State<komposisiForm> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _kandungan = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final sariBuahController saribuahController = Get.put(sariBuahController());
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      saribuahController.addKomposisi(
          Get.arguments[0], _nama.text, _kandungan.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah Komposisi'),
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
                      decoration:
                          const InputDecoration(labelText: 'Nama Komposisi'),
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
                      controller: _kandungan,
                      decoration: const InputDecoration(labelText: 'Kandungan'),
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
