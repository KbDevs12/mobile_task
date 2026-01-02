import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugas_mobile/models/atlet.dart';

// Kelas ini bertanggung jawab untuk semua operasi terkait Firestore.
class FirestoreService {
  // Mendapatkan instance Firestore dan referensi ke koleksi 'atlet'.
  // 'final' berarti variabel ini tidak akan diubah setelah diinisialisasi.
  final CollectionReference _atletCollection =
      FirebaseFirestore.instance.collection('atlet');

  // Method untuk menambahkan data atlet baru ke Firestore.
  // Menggunakan 'Future<void>' karena ini adalah operasi async yang tidak mengembalikan nilai.
  Future<void> addAtlet(Atlet atlet) {
    return _atletCollection.add(atlet.toMap());
  }

  // Method untuk mendapatkan stream (aliran data) dari koleksi atlet.
  // Stream akan otomatis memberi notifikasi jika ada data baru, perubahan, atau data yang dihapus.
  // Ini sangat berguna untuk membangun UI yang reaktif.
  Stream<QuerySnapshot> getAtletStream() {
    return _atletCollection.orderBy('nama').snapshots();
  }
}