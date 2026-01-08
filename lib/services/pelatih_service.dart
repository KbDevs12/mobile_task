import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugas_mobile/models/pelatih.dart';

class PelatihService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection(
    'pelatih',
  );

  Future<void> addPelatih(Pelatih pelatih) async {
    await _ref.add(pelatih.toMap());
  }

  Future<void> updatePelatih(String id, Pelatih pelatih) async {
    await _ref.doc(id).update(pelatih.toMap());
  }

  Future<void> deletePelatih(String id) async {
    await _ref.doc(id).delete();
  }

  Stream<List<Pelatih>> getPelatih() {
    return _ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Pelatih.fromFirestore(doc);
      }).toList();
    });
  }

  // New method to get a single Pelatih by ID
  Future<Pelatih?> getPelatihById(String id) async {
    final doc = await _ref.doc(id).get();
    if (doc.exists) {
      return Pelatih.fromFirestore(doc);
    }
    return null;
  }
}
