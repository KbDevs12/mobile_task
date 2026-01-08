import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cabang_olahraga.dart';

class CabangOlahragaService {
  final CollectionReference _ref = FirebaseFirestore.instance.collection(
    'cabang_olahraga',
  );

  Future<void> addCabang(CabangOlahraga cabang) async {
    await _ref.add(cabang.toMap());
  }

  Future<void> updateCabang(String id, CabangOlahraga cabang) async {
    await _ref.doc(id).update(cabang.toMap());
  }

  Future<void> deleteCabang(String id) async {
    await _ref.doc(id).delete();
  }

  Stream<List<CabangOlahraga>> getCabang() {
    return _ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CabangOlahraga.fromFirestore(doc);
      }).toList();
    });
  }
}
