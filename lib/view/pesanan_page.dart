import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xyz/controller/pesanancontroller.dart';
import 'package:xyz/view/pesanan_form.dart';
import 'package:xyz/helper/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PesananPage extends StatefulWidget {
  PesananPage({Key? key}) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  final PesananController pesanancontroller = Get.put(PesananController());
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('pesanan').snapshots();
  final CollectionReference _invoices =
      FirebaseFirestore.instance.collection('pesanan');

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
                  var path = documentSnapshot['pelanggan'].toString();
                  String pat = path.splitMapJoin(RegExp('\\(.*?\\)'),
                      onMatch: (m) => '${m[0]}', onNonMatch: (n) => '');

                  String patt = pat.substring(1, pat.length - 1);
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: FutureBuilder(
                        future: fireStore.doc(patt).get(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Text(snapshot.data['nama']);
                        },
                      ),
                      subtitle: Column(
                        children: [
                          Text(documentSnapshot['status']),
                          Text(DateFormat.yMd().format(
                              (documentSnapshot['tanggal'] as Timestamp)
                                  .toDate()))
                        ],
                      ),
                      trailing: SizedBox(
                          width: 100,
                          child: PopupMenuButton<Menu>(
                              onSelected: (Menu menu) {
                                if (menu == Menu.edit) {
                                  Get.to(() => PesananForm(), arguments: [
                                    true,
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
                                                "HAPUS INVOICE?",
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
                                                onPressed: () async {
                                                  pesanancontroller
                                                      .HapusPesanan(
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
                                  <PopupMenuEntry<Menu>>[
                                    const PopupMenuItem(
                                      value: Menu.edit,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem(
                                      value: Menu.delete,
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
            Get.to(() => PesananForm(), arguments: [false]);
          })),
          child: Icon(Icons.add),
        ));
  }
}
