import 'package:cloud_firestore/cloud_firestore.dart';

// Kelas model untuk merepresentasikan data seorang atlet.
class Atlet {
  final String? id;
  final String nama;
  final String cabangAtlet;
  final int umur;
  final String jenisKelamin;
  final double beratBadan;
  final double tinggiBadan;

  Atlet({
    this.id,
    required this.nama,
    required this.cabangAtlet,
    required this.umur,
    required this.jenisKelamin,
    required this.beratBadan,
    required this.tinggiBadan,
  });

  // Method untuk mengubah instance Atlet menjadi Map (JSON) agar bisa disimpan di Firestore.
  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'cabangAtlet': cabangAtlet,
      'umur': umur,
      'jenisKelamin': jenisKelamin,
      'beratBadan': beratBadan,
      'tinggiBadan': tinggiBadan,
    };
  }

  // Factory constructor untuk membuat instance Atlet dari sebuah DocumentSnapshot Firestore.
  factory Atlet.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Atlet(
      id: doc.id,
      nama: data['nama'] ?? '',
      cabangAtlet: data['cabangAtlet'] ?? '',
      umur: data['umur'] ?? 0,
      jenisKelamin: data['jenisKelamin'] ?? '',
      // Konversi ke double untuk memastikan tipe data benar
      beratBadan: (data['beratBadan'] as num?)?.toDouble() ?? 0.0,
      tinggiBadan: (data['tinggiBadan'] as num?)?.toDouble() ?? 0.0,
    );
  }
}