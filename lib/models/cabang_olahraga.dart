import 'package:cloud_firestore/cloud_firestore.dart';

class CabangOlahraga {
  final String? id;
  final String namaCabang;
  final String kategori;
  final String tingkat;
  final int jumlahAtlet;
  final String? pelatihId; // New field for Pelatih ID
  final String pelatihNama; // New field for Pelatih Name

  CabangOlahraga({
    this.id,
    required this.namaCabang,
    required this.kategori,
    required this.tingkat,
    required this.jumlahAtlet,
    this.pelatihId, // Make nullable
    required this.pelatihNama, // Make required
  });

  Map<String, dynamic> toMap() {
    return {
      'namaCabang': namaCabang,
      'kategori': kategori,
      'tingkat': tingkat,
      'jumlahAtlet': jumlahAtlet,
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
      jumlahAtlet: data['jumlahAtlet'] ?? 0,
      pelatihId: data['pelatihId'],
      pelatihNama: data['pelatihNama'] ?? 'Tidak Ditentukan', // Default value
    );
  }
}
