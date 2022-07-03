import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/widgets/text_field_input.dart';
import 'package:xyz/controller/usercontroller.dart';

class spbForm extends StatefulWidget {
  spbForm({Key? key}) : super(key: key);

  @override
  State<spbForm> createState() => _spbFormState();
}

class _spbFormState extends State<spbForm> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _telepon = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  final UserController usercontroller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('spbform'),
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
              controller: _username,
              labelText: 'Username',
              icon: Icons.people,
            ),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
              controller: _nama,
              labelText: 'Nama',
              icon: Icons.people_alt_outlined,
            ),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
              controller: _telepon,
              labelText: 'Telepon',
              icon: Icons.local_phone,
            ),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
              controller: _password,
              labelText: 'Password',
              icon: Icons.vpn_key,
              isObscure: true,
            ),
            const SizedBox(
              height: 25,
            ),
            TextInputFields(
              controller: _confirmpass,
              labelText: 'Konfirmasi Password',
              icon: Icons.vpn_key_outlined,
              isObscure: true,
            ),
            const SizedBox(
              height: 25,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () => usercontroller.AddSPB(
                      _username.text,
                      _nama.text,
                      _telepon.text,
                      _password.text,
                      _confirmpass.text),
                  child: Text('Simpan')),
            )
          ],
        ),
      ),
    );
  }
}
