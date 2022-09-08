import 'package:cloud_firestore/cloud_firestore.dart';

class DaftarSpb {
  Stream<QuerySnapshot> getAllSPB() {
    Stream<QuerySnapshot> allSPB = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'SPB')
        .snapshots();
    return allSPB;
  }
}
