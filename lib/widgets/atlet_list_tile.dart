import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart';
import 'package:tugas_mobile/services/atlet_service.dart'; // Change to AtletService
import 'package:tugas_mobile/utils/notifikasi.dart';
import 'package:tugas_mobile/views/add_edit_atlet_screen.dart';

// Widget kustom untuk menampilkan satu item atlet di dalam daftar.
class AtletListTile extends StatelessWidget {
  final Atlet atlet;
  final AtletService atletService; // Change to AtletService

  const AtletListTile({
    super.key,
    required this.atlet,
    required this.atletService, // Change to AtletService
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(atlet.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${atlet.cabangAtlet} - ${atlet.umur} tahun'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tombol untuk mengedit data atlet.
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditAtletScreen(atlet: atlet, atletService: atletService), // Pass atletService
                  ),
                );
              },
            ),
            // Tombol untuk menghapus data atlet.
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                // Tampilkan dialog konfirmasi sebelum menghapus.
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi Hapus'),
                    content: Text('Apakah Anda yakin ingin menghapus data ${atlet.nama}?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Hapus'),
                      ),
                    ],
                  ),
                );

                // Jika pengguna mengkonfirmasi, hapus data.
                if (confirm == true) {
                  try {
                    await atletService.deleteAtlet(atlet.id!); // Use atletService
                    if (context.mounted) {
                      Notifikasi.show(context, 'Data atlet berhasil dihapus.');
                    }
                  } catch (e) {
                     if (context.mounted) {
                      Notifikasi.show(context, 'Gagal menghapus data: $e', isSuccess: false);
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}