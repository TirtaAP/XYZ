import 'package:cloud_firestore/cloud_firestore.dart';

class Stok {
  Stream<QuerySnapshot> getStok() {
    Stream<QuerySnapshot> stok =
        FirebaseFirestore.instance.collection('box').snapshots();
    return stok;
  }
}
