import 'package:cloud_firestore/cloud_firestore.dart';

// Kelas model untuk merepresentasikan data seorang atlet.
class Atlet {
  final String? id;
  final String nama;
  final String cabangAtlet; // This will now store the display name "Cabang - Pelatih"
  final int umur;
  final String jenisKelamin;
  final double beratBadan;
  final double tinggiBadan;
  final String? cabangOlahragaId; // New field for CabangOlahraga ID
  final String cabangOlahragaNama; // New field for CabangOlahraga display name

  Atlet({
    this.id,
    required this.nama,
    required this.cabangAtlet, // Adapting this to store the display name
    required this.umur,
    required this.jenisKelamin,
    required this.beratBadan,
    required this.tinggiBadan,
    this.cabangOlahragaId, // Make nullable
    required this.cabangOlahragaNama, // Make required
  });

  // Method untuk mengubah instance Atlet menjadi Map (JSON) agar bisa disimpan di Firestore.
  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'cabangAtlet': cabangAtlet, // Still keeping this for display
      'umur': umur,
      'jenisKelamin': jenisKelamin,
      'beratBadan': beratBadan,
      'tinggiBadan': tinggiBadan,
      'cabangOlahragaId': cabangOlahragaId,
      'cabangOlahragaNama': cabangOlahragaNama,
    };
  }

  // Factory constructor untuk membuat instance Atlet dari sebuah DocumentSnapshot Firestore.
  factory Atlet.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Atlet(
      id: doc.id,
      nama: data['nama'] ?? '',
      cabangAtlet: data['cabangAtlet'] ?? '', // Retrieve display name
      umur: data['umur'] ?? 0,
      jenisKelamin: data['jenisKelamin'] ?? '',
      // Konversi ke double untuk memastikan tipe data benar
      beratBadan: (data['beratBadan'] as num?)?.toDouble() ?? 0.0,
      tinggiBadan: (data['tinggiBadan'] as num?)?.toDouble() ?? 0.0,
      cabangOlahragaId: data['cabangOlahragaId'],
      cabangOlahragaNama: data['cabangOlahragaNama'] ?? 'Tidak Ditentukan',
    );
  }
}