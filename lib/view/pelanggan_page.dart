import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/usercontroller.dart';
import 'package:xyz/view/pelanggan_form.dart';
import 'package:xyz/controller/pelanggancontroller.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/view/pesanan_form.dart';

class pelangganPage extends StatefulWidget {
  pelangganPage({Key? key}) : super(key: key);

  @override
  State<pelangganPage> createState() => _pelangganPageState();
}

class _pelangganPageState extends State<pelangganPage> {
  final PelangganController pelanggancontroller =
      Get.put(PelangganController());
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('pelanggan').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['nama']),
                      trailing: SizedBox(
                          width: 100,
                          child: PopupMenuButton<PelangganM>(
                              onSelected: (PelangganM pelanggan) {
                                if (pelanggan == PelangganM.edit) {
                                  Get.to(() => PelangganForm(), arguments: [
                                    true,
                                    documentSnapshot.id,
                                    documentSnapshot['nama'],
                                    documentSnapshot['telepon'],
                                    documentSnapshot['alamat'],
                                    documentSnapshot['provinsi'],
                                    documentSnapshot['kota'],
                                    documentSnapshot['contactperson']
                                  ]);
                                }
                                if (pelanggan == PelangganM.pesan) {
                                  Get.to(() => PesananForm(), arguments: [
                                    false,
                                    documentSnapshot.id,
                                    documentSnapshot['nama'],
                                  ]);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            titlePadding:
                                                const EdgeInsets.all(0),
                                            title: Container(
                                              padding: const EdgeInsets.all(5),
                                              color: Colors.red,
                                              child: const Center(
                                                  child: Text(
                                                "HAPUS Pelanggan?",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.grey),
                                                child: const Text("BATAL"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  pelanggancontroller
                                                      .hapusPelanggan(context,
                                                          documentSnapshot.id);
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red),
                                                child: const Text("HAPUS"),
                                              ),
                                            ],
                                          ));
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<PelangganM>>[
                                    const PopupMenuItem(
                                      value: PelangganM.pesan,
                                      child: Text("Buat Pesanan"),
                                    ),
                                    const PopupMenuItem(
                                      value: PelangganM.edit,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: PelangganM.delete,
                                      child: Text("Delete"),
                                    )
                                  ])),
                    ),
                  );
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => PelangganForm(), arguments: [false]);
          })),
          child: Icon(Icons.add),
        ));
  }
}
