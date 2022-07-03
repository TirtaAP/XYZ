import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/controller/usercontroller.dart';
import 'package:xyz/view/pelanggan_form.dart';
import 'package:xyz/controller/pelanggancontroller.dart';
import 'package:xyz/helper/constant.dart';

class pelangganPage extends StatefulWidget {
  pelangganPage({Key? key}) : super(key: key);

  @override
  State<pelangganPage> createState() => _pelangganPageState();
}

class _pelangganPageState extends State<pelangganPage> {
  final PelangganController pelanggancontroller =
      Get.put(PelangganController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: PelangganController.GetAllpelanggan(),
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
                      title: Text(documentSnapshot['nama']),
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
            Get.to(() => PelangganForm());
          })),
          child: Icon(Icons.add),
        ));
  }
}
