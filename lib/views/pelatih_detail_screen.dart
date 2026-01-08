import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/pelatih.dart';
import 'package:tugas_mobile/services/pelatih_service.dart';

class PelatihDetailScreen extends StatelessWidget {
  final String pelatihId;
  final PelatihService _pelatihService = PelatihService();

  PelatihDetailScreen({super.key, required this.pelatihId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pelatih'),
      ),
      body: FutureBuilder<Pelatih?>(
        future: _pelatihService.getPelatihById(pelatihId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Pelatih tidak ditemukan.'));
          }

          final pelatih = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pelatih.nama,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    _buildDetailRow('Cabang Olahraga', pelatih.cabangOlahraga),
                    _buildDetailRow('Umur', '${pelatih.umur} tahun'),
                    _buildDetailRow('Jenis Kelamin', pelatih.jenisKelamin),
                    _buildDetailRow('Pengalaman', '${pelatih.pengalamanTahun} tahun'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
