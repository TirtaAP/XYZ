import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/view/saribuah_form.dart';
import 'package:xyz/helper/constant.dart';
import 'package:xyz/controller/sariBuahcontroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class barangPage extends StatefulWidget {
  barangPage({Key? key}) : super(key: key);

  @override
  State<barangPage> createState() => _barangPageState();
}

class _barangPageState extends State<barangPage> {
  final sariBuahController barangcontroller = Get.put(sariBuahController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: barangcontroller.GetAllBarang(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['tanggal']),
                      subtitle: Text(documentSnapshot['biaya'].toString()),
                      trailing: SizedBox(
                          width: 100,
                          child: PopupMenuButton<Menu>(
                              onSelected: (Menu menu) {},
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
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
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
