import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cabang_olahraga.dart';
import '../providers/cabang_olahraga_provider.dart';
import '../widgets/cabang_olahraga_list_tile.dart';

import 'add_edit_cabang_olahraga_screen.dart';

class CabangOlahragaListScreen extends StatelessWidget {
  const CabangOlahragaListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cabangOlahragaProvider = Provider.of<CabangOlahragaProvider>(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return StreamBuilder<List<CabangOlahraga>>(
      stream: cabangOlahragaProvider.cabangOlahragaStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.error)));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Tidak ada data cabang olahraga. Tambahkan yang baru!', style: textTheme.bodyLarge));
        } else {
          final cabangOlahragaList = snapshot.data!;
          return ListView.builder(
            itemCount: cabangOlahragaList.length,
            itemBuilder: (context, index) {
              final cabangOlahraga = cabangOlahragaList[index];
              return CabangOlahragaListTile(
                cabangOlahraga: cabangOlahraga,
                onTap: () {
                  Navigator.pushNamed(context, '/add-cabang-olahraga', arguments: cabangOlahraga);
                },
                onDelete: () async {
                  final confirmDelete = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Hapus Cabang Olahraga', style: textTheme.titleLarge),
                      content: Text('Apakah Anda yakin ingin menghapus ${cabangOlahraga.namaCabang}?', style: textTheme.bodyMedium),
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
                    final success = await cabangOlahragaProvider.deleteCabangOlahraga(cabangOlahraga.id!);
                    if (success) {
                      Notifikasi.show(context, 'Cabang Olahraga berhasil dihapus!');
                    } else {
                      Notifikasi.show(context, cabangOlahragaProvider.errorMessage ?? 'Gagal menghapus cabang olahraga.', isSuccess: false);
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
