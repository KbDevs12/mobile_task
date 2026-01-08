import 'package:cloud_firestore/cloud_firestore.dart';

class CabangOlahraga {
  final String? id;
  final String namaCabang;
  final String kategori;
  final String tingkat;
  final int jumlahAtlet;

  CabangOlahraga({
    this.id,
    required this.namaCabang,
    required this.kategori,
    required this.tingkat,
    required this.jumlahAtlet,
  });

  Map<String, dynamic> toMap() {
    return {
      'namaCabang': namaCabang,
      'kategori': kategori,
      'tingkat': tingkat,
      'jumlahAtlet': jumlahAtlet,
    };
  }

  factory CabangOlahraga.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CabangOlahraga(
      id: doc.id,
      namaCabang: data['namaCabang'] ?? '',
      kategori: data['kategori'] ?? '',
      tingkat: data['tingkat'] ?? '',
      jumlahAtlet: data['jumlahAtlet'] ?? 0,
    );
  }
}
