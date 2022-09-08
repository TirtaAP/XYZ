import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xyz/view/pesanan_form.dart';
import 'package:xyz/view/stok_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/sariBuahcontroller.dart';
import 'package:xyz/helper/constant.dart';

class stockPage extends StatefulWidget {
  stockPage({Key? key}) : super(key: key);

  @override
  State<stockPage> createState() => _stockPageState();
}

class _stockPageState extends State<stockPage> {
  final sariBuahController saribuahcontroller = Get.put(sariBuahController());
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('box').snapshots();

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
                    child: ListTile(
                        title: Text(documentSnapshot['saribuah']['isiBersih']),
                        subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Tanggal Produksi     :'),
                                        Text(DateFormat.yMd().format(
                                            (documentSnapshot['saribuah']
                                                        ['tglProduksi']
                                                    as Timestamp)
                                                .toDate()))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Tanggal Kadaluarsa :'),
                                        Text(DateFormat.yMd().format(
                                            (documentSnapshot['saribuah']
                                                        ['tglKadaluarsa']
                                                    as Timestamp)
                                                .toDate()))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Isi :'),
                                        Text((documentSnapshot['isi']
                                            .toString()))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Stok :'),
                                        Text((documentSnapshot['jumlah']
                                            .toString()))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Harga :'),
                                        Text((documentSnapshot['harga']
                                            .toString()))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ]),
                        trailing: SizedBox(
                            width: 100,
                            child: PopupMenuButton<Stok>(
                                onSelected: (Stok stok) {
                                  if (stok == Stok.pesan) {
                                    Get.to(() => PesananForm(),
                                        arguments: [documentSnapshot.id]);
                                  } else if (stok == Stok.edit) {
                                    Get.to(() => StokForm(), arguments: [
                                      true,
                                      documentSnapshot.id,
                                      documentSnapshot['isiBersih']
                                    ]);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              titlePadding:
                                                  const EdgeInsets.all(0),
                                              title: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                color: Colors.red,
                                                child: const Center(
                                                    child: Text(
                                                  "HAPUS SARI BUAH?",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.grey),
                                                  child: const Text("BATAL"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    saribuahcontroller
                                                        .hapusStokSaribuah(
                                                            documentSnapshot
                                                                .id);
                                                    Get.back();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.red),
                                                  child: const Text("HAPUS"),
                                                ),
                                              ],
                                            ));
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<Stok>>[
                                      const PopupMenuItem(
                                        value: Stok.edit,
                                        child: Text("Edit"),
                                      ),
                                      const PopupMenuItem(
                                        value: Stok.delete,
                                        child: Text("Delete"),
                                      ),
                                    ]))),
                  );
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => StokForm());
          })),
          child: Icon(Icons.add),
        ));
  }
}
