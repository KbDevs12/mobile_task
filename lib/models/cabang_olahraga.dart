import 'package:cloud_firestore/cloud_firestore.dart';

class CabangOlahraga {
  final String? id;
  final String namaCabang;
  final String kategori; // Changed from required
  final String tingkat; // Changed from required
  // final int jumlahAtlet; // Removed
  final String? pelatihId;
  final String pelatihNama;

  CabangOlahraga({
    this.id,
    required this.namaCabang,
    this.kategori = '', // Provide default value
    this.tingkat = '', // Provide default value
    // required this.jumlahAtlet, // Removed
    this.pelatihId,
    required this.pelatihNama,
  });

  Map<String, dynamic> toMap() {
    return {
      'namaCabang': namaCabang,
      'kategori': kategori,
      'tingkat': tingkat,
      // 'jumlahAtlet': jumlahAtlet, // Removed
      'pelatihId': pelatihId,
      'pelatihNama': pelatihNama,
    };
  }

  factory CabangOlahraga.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CabangOlahraga(
      id: doc.id,
      namaCabang: data['namaCabang'] ?? '',
      kategori: data['kategori'] ?? '',
      tingkat: data['tingkat'] ?? '',
      // jumlahAtlet: data['jumlahAtlet'] ?? 0, // Removed
      pelatihId: data['pelatihId'],
      pelatihNama: data['pelatihNama'] ?? 'Tidak Ditentukan', // Default value
    );
  }
}


