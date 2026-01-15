import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart';
import 'package:tugas_mobile/services/atlet_service.dart'; // Change to AtletService
import 'package:tugas_mobile/views/add_edit_atlet_screen.dart';
import 'package:tugas_mobile/widgets/atlet_list_tile.dart';
import 'package:tugas_mobile/widgets/gradient_app_bar.dart'; // Import GradientAppBar
import 'package:tugas_mobile/widgets/loading_skeleton.dart'; // Import LoadingListSkeleton

// Halaman utama yang menampilkan daftar atlet.
class AtletListScreen extends StatefulWidget {
  const AtletListScreen({super.key});

  @override
  State<AtletListScreen> createState() => _AtletListScreenState();
}

class _AtletListScreenState extends State<AtletListScreen> {
  // Instance dari AtletService untuk mengakses database.
  final AtletService _atletService = AtletService(); // Change to AtletService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: 'Daftar Atlet'),
      body: StreamBuilder<List<Atlet>>(
        // Stream now returns List<Atlet> directly
        // Menggunakan stream dari AtletService untuk mendapatkan data atlet secara real-time.
        stream: _atletService
            .getAtletStream(), // Use getAtletStream from AtletService
        builder: (context, snapshot) {
          // Jika koneksi sedang menunggu data, tampilkan loading indicator.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingListSkeleton(); // Use LoadingListSkeleton
          }
          // Jika tidak ada data, tampilkan pesan.
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Check for empty list
            return const Center(child: Text('Belum ada data atlet.'));
          }
          // Jika terjadi error, tampilkan pesan error.
          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}'),
            ); // Show error message
          }

          // Jika data berhasil didapat, bangun daftar atlet.
          final atletList = snapshot.data!; // atletList is already List<Atlet>

          return ListView.builder(
            itemCount: atletList.length,
            itemBuilder: (context, index) {
              // Ubah setiap dokumen menjadi objek Atlet. (No longer needed, already Atlet object)
              final atlet = atletList[index];
              // Gunakan widget kustom AtletListTile untuk menampilkan data.
              return AtletListTile(
                atlet: atlet,
                atletService: _atletService, // Pass AtletService
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
              builder: (context) => AddEditAtletScreen(
                atletService: _atletService,
              ), // Pass AtletService
            ),
          );
        },
        tooltip: 'Tambah Atlet',
        child: const Icon(Icons.add),
      ),
    );
  }
}
