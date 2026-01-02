import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart';

// Halaman ini berfungsi untuk menambah atau mengedit data atlet.
class AddEditAtletScreen extends StatefulWidget {
  // Atlet opsional, jika ada berarti mode 'Edit', jika null berarti mode 'Tambah'.
  final Atlet? atlet;

  const AddEditAtletScreen({super.key, this.atlet});

  @override
  State<AddEditAtletScreen> createState() => _AddEditAtletScreenState();
}

class _AddEditAtletScreenState extends State<AddEditAtletScreen> {
  // Kunci global untuk form, digunakan untuk validasi.
  final _formKey = GlobalKey<FormState>();

  // Controller untuk setiap input field.
  late TextEditingController _namaController;
  late TextEditingController _cabangController;
  late TextEditingController _umurController;
  late TextEditingController _beratController;
  late TextEditingController _tinggiController;
  String? _jenisKelamin; // Variabel untuk menyimpan pilihan dropdown.

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller. Jika mode 'Edit', isi dengan data atlet yang ada.
    _namaController = TextEditingController(text: widget.atlet?.nama);
    _cabangController = TextEditingController(text: widget.atlet?.cabangAtlet);
    _umurController = TextEditingController(text: widget.atlet?.umur.toString());
    _beratController = TextEditingController(text: widget.atlet?.beratBadan.toString());
    _tinggiController = TextEditingController(text: widget.atlet?.tinggiBadan.toString());
    _jenisKelamin = widget.atlet?.jenisKelamin;
  }

  @override
  void dispose() {
    // Selalu dispose controller setelah tidak digunakan untuk menghindari memory leak.
    _namaController.dispose();
    _cabangController.dispose();
    _umurController.dispose();
    _beratController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.atlet == null ? 'Tambah Atlet' : 'Edit Atlet'),
      ),
      body: const Center(
        child: Text('Form akan dibuat di sini.'),
      ),
    );
  }
}