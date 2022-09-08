import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/entity/sertifikat.dart';
import 'package:xyz/view/komposisi_form.dart';
import 'package:xyz/view/saribuah_form.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/view/sertifikat_form.dart';

class SariBuahPage extends StatefulWidget {
  SariBuahPage({Key? key}) : super(key: key);

  @override
  State<SariBuahPage> createState() => _SariBuahPageState();
}

class _SariBuahPageState extends State<SariBuahPage> {
  final sariBuahController saribuahcontroller = Get.put(sariBuahController());
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('saribuah').snapshots();

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
                  List sertifikat;
                  List komposisi = List.from(documentSnapshot['komposisi']);
                  if (documentSnapshot['sertifikat'] == null) {
                    sertifikat = [
                      {"lembaga": "", "noSertifikat": ""}
                    ];
                  } else {
                    sertifikat = List.from(documentSnapshot['sertifikat']);
                  }

                  return Card(
                    child: ListTile(
                      title: Text(documentSnapshot['isiBersih']),
                      subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Text(
                                    'Komposisi',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  for (var komposisi in komposisi)
                                    Text((komposisi
                                            as Map<String, dynamic>)['nama'] +
                                        '   ' +
                                        (komposisi as Map<String, dynamic>)[
                                            'kandungan']),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Sertifikat',
                                  ),
                                  for (var sertifikat in sertifikat)
                                    Column(
                                      children: [
                                        Text(
                                          (sertifikat as Map<String, dynamic>)[
                                                  'lembaga'] +
                                              '   ' +
                                              (sertifikat as Map<String,
                                                  dynamic>)['noSertifikat'],
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ]),
                      trailing: SizedBox(
                          width: 100,
                          child: PopupMenuButton<Sarbu>(
                              onSelected: (Sarbu sarbu) {
                                if (sarbu == Sarbu.komposisi) {
                                  Get.to(() => komposisiForm(),
                                      arguments: [documentSnapshot.id]);
                                } else if (sarbu == Sarbu.edit) {
                                  Get.to(() => komposisiForm(), arguments: [
                                    true,
                                    documentSnapshot.id,
                                    documentSnapshot['isiBersih']
                                  ]);
                                } else if (sarbu == Sarbu.sertifikat) {
                                  Get.to(() => SertifikatForm(), arguments: [
                                    true,
                                    documentSnapshot.id,
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
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.grey),
                                                child: const Text("BATAL"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  saribuahcontroller
                                                      .hapusSaribuah(
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
                                  <PopupMenuEntry<Sarbu>>[
                                    const PopupMenuItem(
                                      value: Sarbu.edit,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: Sarbu.delete,
                                      child: Text("Delete"),
                                    ),
                                    const PopupMenuItem(
                                      value: Sarbu.komposisi,
                                      child: Text("Tambah Komposisi"),
                                    ),
                                    const PopupMenuItem(
                                      value: Sarbu.sertifikat,
                                      child: Text("Tambah Sertifikat"),
                                    )
                                  ])),
                    ),
                  );
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => BarangForm());
          })),
          child: Icon(Icons.add),
        ));
  }
}
