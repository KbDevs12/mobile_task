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
}