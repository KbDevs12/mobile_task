import 'package:flutter/material.dart';

class PelatihListScreen extends StatelessWidget {
  const PelatihListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pelatih'),
      ),
      body: const Center(
        child: Text(
          'Halaman untuk menampilkan daftar pelatih.',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement navigation to add coach screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
