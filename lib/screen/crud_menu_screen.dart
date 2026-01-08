import 'package:flutter/material.dart';

class CrudMenuScreen extends StatelessWidget {
  const CrudMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Data CRUD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Cabang Olahraga List Screen
              },
              child: const Text('Kelola Cabang Olahraga'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Pelatih List Screen
              },
              child: const Text('Kelola Pelatih'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Atlet List Screen
              },
              child: const Text('Kelola Atlet'),
            ),
          ],
        ),
      ),
    );
  }
}
