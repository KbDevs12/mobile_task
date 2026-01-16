import 'package:flutter/material.dart';
import 'package:atlet_manager/models/pelatih.dart';
import 'package:atlet_manager/services/pelatih_service.dart';
import 'package:atlet_manager/utils/notifikasi.dart';
import 'package:atlet_manager/views/add_edit_pelatih_screen.dart';

class PelatihListTile extends StatelessWidget {
  final Pelatih pelatih;
  final PelatihService pelatihService;

  const PelatihListTile({
    super.key,
    required this.pelatih,
    required this.pelatihService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card styling from main.dart CardTheme
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Consistent padding
        child: Row(
          children: [
            // Trainer Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.secondary.withOpacity(0.1),
              child: Icon(
                Icons.person_outline,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ), // Generic trainer icon
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelatih.nama,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${pelatih.cabangOlahraga} - ${pelatih.umur} tahun',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    'Pengalaman: ${pelatih.pengalamanTahun} tahun',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            // Action Buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditPelatihScreen(
                          pelatih: pelatih,
                          pelatihService: pelatihService,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Konfirmasi Hapus'),
                        content: Text(
                          'Apakah Anda yakin ingin menghapus pelatih ${pelatih.nama}?',
                        ),
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
                        await pelatihService.deletePelatih(pelatih.id!);
                        if (context.mounted) {
                          Notifikasi.show(context, 'Pelatih berhasil dihapus.');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Notifikasi.show(
                            context,
                            'Gagal menghapus data: $e',
                            isSuccess: false,
                          );
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
