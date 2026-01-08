import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/atlet.dart';
import '../providers/atlet_provider.dart';
import '../widgets/atlet_list_tile.dart';
import '../utils/notifikasi.dart';


// Layar untuk menampilkan daftar atlet
class AtletListScreen extends StatelessWidget {
  const AtletListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengakses AtletProvider
    final atletProvider = Provider.of<AtletProvider>(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return StreamBuilder<List<Atlet>>(
      stream: atletProvider.atletsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan indikator loading saat menunggu data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Tampilkan pesan error jika ada
          return Center(child: Text('Error: ${snapshot.error}', style: textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.error)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Tampilkan pesan jika tidak ada data atlet
          return Center(child: Text('Tidak ada data atlet. Tambahkan yang baru!', style: textTheme.bodyLarge));
        } else {
          // Tampilkan daftar atlet menggunakan ListView.builder
          final atlets = snapshot.data!;
          return ListView.builder(
            itemCount: atlets.length,
            itemBuilder: (context, index) {
              final atlet = atlets[index];
              return AtletListTile(
                atlet: atlet,
                onTap: () {
                  // Navigasi ke AddEditAtletScreen untuk mengedit atlet
                  Navigator.pushNamed(context, '/add-atlet', arguments: atlet);
                },
                onDelete: () async {
                  // Tampilkan konfirmasi dialog sebelum menghapus
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Hapus Atlet', style: textTheme.titleLarge),
                      content: Text('Apakah Anda yakin ingin menghapus ${atlet.nama}?', style: textTheme.bodyMedium),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Batal', style: textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Hapus', style: textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.error)),
                        ),
                      ],
                    ),
                  );

                  if (confirmDelete == true) {
                      final success = await atletProvider.deleteAtlet(atlet.id!);
                      if (success) {
                        Notifikasi.show(context, 'Atlet berhasil dihapus!');
                      } else {
                        Notifikasi.show(context, atletProvider.errorMessage ?? 'Gagal menghapus atlet.', isSuccess: false);
                      }
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}