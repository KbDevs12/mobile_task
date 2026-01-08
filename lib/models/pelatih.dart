import 'package:cloud_firestore/cloud_firestore.dart';

class Pelatih {
  final String? id;
  final String nama;
  final String cabangOlahraga;
  final int umur;
  final String jenisKelamin;
  final int pengalamanTahun;

  Pelatih({
    this.id,
    required this.nama,
    required this.cabangOlahraga,
    required this.umur,
    required this.jenisKelamin,
    required this.pengalamanTahun,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'cabangOlahraga': cabangOlahraga,
      'umur': umur,
      'jenisKelamin': jenisKelamin,
      'pengalamanTahun': pengalamanTahun,
    };
  }

  factory Pelatih.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Pelatih(
      id: doc.id,
      nama: data['nama'] ?? '',
      cabangOlahraga: data['cabangOlahraga'] ?? '',
      umur: data['umur'] ?? 0,
      jenisKelamin: data['jenisKelamin'] ?? '',
      pengalamanTahun: data['pengalamanTahun'] ?? 0,
    );
  }
}
