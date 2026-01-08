import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart';
import 'package:tugas_mobile/services/atlet_service.dart';
import 'package:tugas_mobile/views/add_edit_atlet_screen.dart'; // For adding new atlet
import 'package:tugas_mobile/widgets/atlet_list_tile.dart';

class AtletByCabangScreen extends StatefulWidget {
  final String cabangOlahragaId;
  final String cabangOlahragaNama;

  const AtletByCabangScreen({
    super.key,
    required this.cabangOlahragaId,
    required this.cabangOlahragaNama,
  });

  @override
  State<AtletByCabangScreen> createState() => _AtletByCabangScreenState();
}

class _AtletByCabangScreenState extends State<AtletByCabangScreen> {
  final AtletService _atletService = AtletService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atlet ${widget.cabangOlahragaNama}'),
      ),
      body: StreamBuilder<List<Atlet>>(
        stream: _atletService.getAtletStream().map((atletList) =>
            atletList
                .where((atlet) => atlet.cabangOlahragaId == widget.cabangOlahragaId)
                .toList()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada atlet untuk cabang ${widget.cabangOlahragaNama}.'));
          }

          final atletList = snapshot.data!;

          return ListView.builder(
            itemCount: atletList.length,
            itemBuilder: (context, index) {
              final atlet = atletList[index];
              return AtletListTile(
                atlet: atlet,
                atletService: _atletService,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditAtletScreen(atletService: _atletService),
            ),
          );
        },
        tooltip: 'Tambah Atlet',
        child: const Icon(Icons.add),
      ),
    );
  }
}
