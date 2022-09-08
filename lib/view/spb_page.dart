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
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

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
                      subtitle: Text(documentSnapshot['telepon']),
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
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ((() {
            Get.to(() => SpbForm());
          })),
          child: Icon(Icons.add),
        ));
  }
}
