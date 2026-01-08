import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pelatih.dart';
import '../providers/pelatih_provider.dart';
import '../widgets/pelatih_list_tile.dart';
import '../utils/notifikasi.dart';



class PelatihListScreen extends StatelessWidget {
  const PelatihListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pelatihProvider = Provider.of<PelatihProvider>(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return StreamBuilder<List<Pelatih>>(
      stream: pelatihProvider.pelatihStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.error)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Tidak ada data pelatih. Tambahkan yang baru!', style: textTheme.bodyLarge));
        } else {
          final pelatihList = snapshot.data!;
          return ListView.builder(
            itemCount: pelatihList.length,
            itemBuilder: (context, index) {
              final pelatih = pelatihList[index];
              return PelatihListTile(
                pelatih: pelatih,
                onTap: () {
                  Navigator.pushNamed(context, '/add-pelatih', arguments: pelatih);
                },
                onDelete: () async {
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Hapus Pelatih', style: textTheme.titleLarge),
                      content: Text('Apakah Anda yakin ingin menghapus ${pelatih.nama}?', style: textTheme.bodyMedium),
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
                    final success = await pelatihProvider.deletePelatih(pelatih.id!);
                    if (success) {
                      Notifikasi.show(context, 'Pelatih berhasil dihapus!');
                    } else {
                      Notifikasi.show(context, pelatihProvider.errorMessage ?? 'Gagal menghapus pelatih.', isSuccess: false);
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
