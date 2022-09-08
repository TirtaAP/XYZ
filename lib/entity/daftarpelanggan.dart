import 'package:cloud_firestore/cloud_firestore.dart';

class Daftarelanggan {
  Stream<QuerySnapshot> getAllPelanggan() {
    Stream<QuerySnapshot> daftarpelanggan =
        FirebaseFirestore.instance.collection('pelanggan').snapshots();
    return daftarpelanggan;
  }
}
