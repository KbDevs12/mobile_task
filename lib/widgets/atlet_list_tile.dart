import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart';
import 'package:tugas_mobile/services/atlet_service.dart';
import 'package:tugas_mobile/utils/notifikasi.dart';
import 'package:tugas_mobile/views/add_edit_atlet_screen.dart';

// Widget kustom untuk menampilkan satu item atlet di dalam daftar.
class AtletListTile extends StatelessWidget {
  final Atlet atlet;
  final AtletService atletService;

  const AtletListTile({
    super.key,
    required this.atlet,
    required this.atletService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card styling from main.dart CardTheme
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Consistent padding
        child: Row(
          children: [
            // Athlete Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(Icons.person, size: 30, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    atlet.nama,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${atlet.cabangOlahragaNama} - ${atlet.umur} tahun',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                  ),
                  Text(
                    '${atlet.jenisKelamin}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditAtletScreen(atlet: atlet, atletService: atletService),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                  onPressed: () async {
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

                    if (confirm == true) {
                      try {
                        await atletService.deleteAtlet(atlet.id!);
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
          ],
        ),
      ),
    );
  }
}