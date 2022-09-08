import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/usercontroller.dart';
import 'package:xyz/view/spb_page.dart';

class SpbForm extends StatefulWidget {
  const SpbForm({Key? key}) : super(key: key);

  @override
  State<SpbForm> createState() => _SpbFormState();
}

class _SpbFormState extends State<SpbForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _telepon = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  final UserController usercontroller = Get.put(UserController());
  final _formKey = GlobalKey<FormState>();
  String? pass;
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      usercontroller.AddSPB(
          context, _email.text, _nama.text, _telepon.text, _password.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Tambah SPB'),
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
                      controller: _email,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Email Valid';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Mohon Masukan Email Valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _nama,
                      decoration: const InputDecoration(labelText: 'Nama'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Nama';
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
                          return 'Mohon Masukan Telepon';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Mohon Masukan Password';
                        }
                        if (value.trim().length < 8) {
                          return 'Password  harus 8 karakter';
                        }
                        // Return null if the entered password is valid
                        pass = value;
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Konfirmasi Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi Password Tidak Sama';
                          }

                          if (value != pass) {
                            return 'Konfirmasi Password Tidak Sama';
                          }
                          // Return null if the entered password is valid

                          return null;
                        }),
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
