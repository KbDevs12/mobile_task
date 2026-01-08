import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugas_mobile/models/atlet.dart';

class AtletService {
  final CollectionReference _atletCollection =
      FirebaseFirestore.instance.collection('atlet');

  Future<void> addAtlet(Atlet atlet) {
    return _atletCollection.add(atlet.toMap());
  }

  Stream<List<Atlet>> getAtletStream() {
    return _atletCollection.orderBy('nama').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Atlet.fromFirestore(doc);
      }).toList();
    });
  }

  Future<void> updateAtlet(Atlet atlet) {
    return _atletCollection.doc(atlet.id).update(atlet.toMap());
  }

  Future<void> deleteAtlet(String atletId) {
    return _atletCollection.doc(atletId).delete();
  }

  // New method to get a stream of athlete count by Cabang Olahraga ID
  Stream<int> getAtletCountByCabangOlahraga(String cabangOlahragaId) {
    return _atletCollection
        .where('cabangOlahragaId', isEqualTo: cabangOlahragaId)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
}