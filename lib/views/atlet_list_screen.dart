import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart';
import 'package:tugas_mobile/services/firestore_service.dart';
import 'package:tugas_mobile/views/add_edit_atlet_screen.dart';
import 'package:tugas_mobile/widgets/atlet_list_tile.dart';

// Halaman utama yang menampilkan daftar atlet.
class AtletListScreen extends StatefulWidget {
  const AtletListScreen({super.key});

  @override
  State<AtletListScreen> createState() => _AtletListScreenState();
}

class _AtletListScreenState extends State<AtletListScreen> {
  // Instance dari FirestoreService untuk mengakses database.
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Atlet'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Menggunakan stream dari FirestoreService untuk mendapatkan data atlet secara real-time.
        stream: _firestoreService.getAtletStream(),
        builder: (context, snapshot) {
          // Jika koneksi sedang menunggu data, tampilkan loading indicator.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Jika tidak ada data, tampilkan pesan.
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Belum ada data atlet.'));
          }
          // Jika terjadi error, tampilkan pesan error.
          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan.'));
          }

          // Jika data berhasil didapat, bangun daftar atlet.
          final atletList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: atletList.length,
            itemBuilder: (context, index) {
              // Ubah setiap dokumen menjadi objek Atlet.
              final atlet = Atlet.fromFirestore(atletList[index]);
              // Gunakan widget kustom AtletListTile untuk menampilkan data.
              return AtletListTile(
                atlet: atlet,
                firestoreService: _firestoreService,
              );
            },
          );
        },
      ),
      // Tombol untuk navigasi ke halaman tambah atlet.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditAtletScreen(),
            ),
          );
        },
        tooltip: 'Tambah Atlet',
        child: const Icon(Icons.add),
      ),
    );
  }
}