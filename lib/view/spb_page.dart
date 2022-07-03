import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/view/spb_form.dart';
import 'package:xyz/helper/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xyz/controller/usercontroller.dart';

class spbPage extends StatefulWidget {
  spbPage({Key? key}) : super(key: key);

  @override
  State<spbPage> createState() => _spbPageState();
}

class _spbPageState extends State<spbPage> {
  final UserController usercontroller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: UserController.GetAllpelanggan(),
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
            Get.to(() => spbForm());
          })),
          child: Icon(Icons.add),
        ));
  }
}
