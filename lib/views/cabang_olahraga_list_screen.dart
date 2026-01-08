import 'package:flutter/material.dart';

class CabangOlahragaListScreen extends StatelessWidget {
  const CabangOlahragaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Cabang Olahraga'),
      ),
      body: const Center(
        child: Text(
          'Halaman untuk menampilkan daftar cabang olahraga.',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement navigation to add sport branch screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
