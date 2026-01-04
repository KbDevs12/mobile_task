import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tugas_mobile/views/atlet_list_screen.dart';
import 'firebase_options.dart';
import './screen/dashboard.dart';

void main() async {
  // Pastikan Flutter binding sudah diinisialisasi sebelum menjalankan kode async.
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Informasi Atlet',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // Halaman awal aplikasi adalah AtletListScreen
      home: const Dashboard(),
    );
  }
}
