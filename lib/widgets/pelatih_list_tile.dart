import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/pelatih.dart';
import 'package:tugas_mobile/services/pelatih_service.dart';
import 'package:tugas_mobile/utils/notifikasi.dart';
import 'package:tugas_mobile/views/add_edit_pelatih_screen.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(pelatih.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${pelatih.cabangOlahraga} - ${pelatih.umur} tahun (${pelatih.pengalamanTahun} th pengalaman)'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
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
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi Hapus'),
                    content: Text('Apakah Anda yakin ingin menghapus pelatih ${pelatih.nama}?'),
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
