import 'package:flutter/material.dart';

// File utilitas untuk menampilkan notifikasi (SnackBar).
class Notifikasi {
  // Method statis agar bisa dipanggil langsung dari kelasnya tanpa perlu membuat instance.
  // Contoh: Notifikasi.show(context, 'Pesan Anda');
  static void show(BuildContext context, String message, {bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}