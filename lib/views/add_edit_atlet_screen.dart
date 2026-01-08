import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart';

import 'package:tugas_mobile/services/atlet_service.dart'; // Change to AtletService
import 'package:tugas_mobile/utils/notifikasi.dart';

// Halaman ini berfungsi untuk menambah atau mengedit data atlet.
class AddEditAtletScreen extends StatefulWidget {
  // Atlet opsional, jika ada berarti mode 'Edit', jika null berarti mode 'Tambah'.
  final Atlet? atlet;
  final AtletService atletService; // Receive AtletService

  const AddEditAtletScreen({super.key, this.atlet, required this.atletService}); // Update constructor

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

  // Instance dari AtletService. (No longer directly instantiated here, received via widget)
  late final AtletService _atletService;

  // Flag untuk menandai apakah sedang dalam proses loading.
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _atletService = widget.atletService; // Initialize from widget
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

  // Method untuk menyimpan atau memperbarui data.
  void _saveAtlet() async {
    // Validasi form terlebih dahulu.
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final atletBaru = Atlet(
          id: widget.atlet?.id, // ID tetap jika mode 'Edit'.
          nama: _namaController.text,
          cabangAtlet: _cabangController.text,
          umur: int.parse(_umurController.text),
          jenisKelamin: _jenisKelamin!,
          beratBadan: double.parse(_beratController.text),
          tinggiBadan: double.parse(_tinggiController.text),
        );

        if (widget.atlet == null) {
          // Mode 'Tambah'
          await _atletService.addAtlet(atletBaru);
           if (context.mounted) Notifikasi.show(context, 'Atlet berhasil ditambahkan.');
        } else {
          // Mode 'Edit'
          await _atletService.updateAtlet(atletBaru);
           if (context.mounted) Notifikasi.show(context, 'Data atlet berhasil diperbarui.');
        }

        if (context.mounted) Navigator.pop(context); // Kembali ke halaman daftar.

      } catch (e) {
        setState(() => _isLoading = false);
        if (context.mounted) Notifikasi.show(context, 'Gagal menyimpan: $e', isSuccess: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.atlet == null ? 'Tambah Atlet' : 'Edit Atlet'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextFormField(_namaController, 'Nama'),
              const SizedBox(height: 16),
              _buildTextFormField(_cabangController, 'Cabang Atlet'),
              const SizedBox(height: 16),
              _buildTextFormField(_umurController, 'Umur', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildGenderDropdown(),
              const SizedBox(height: 16),
              _buildTextFormField(_beratController, 'Berat Badan (kg)', keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextFormField(_tinggiController, 'Tinggi Badan (cm)', keyboardType: TextInputType.number),
              const SizedBox(height: 32),
              // Tombol simpan, nonaktif saat loading.
              ElevatedButton(
                onPressed: _isLoading ? null : _saveAtlet,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,))
                    : const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget untuk membuat TextFormField agar tidak duplikat kode.
  TextFormField _buildTextFormField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label tidak boleh kosong.';
        }
        if (keyboardType == TextInputType.number && double.tryParse(value) == null) {
          return 'Masukkan angka yang valid.';
        }
        return null;
      },
    );
  }

  // Helper widget untuk dropdown jenis kelamin.
  DropdownButtonFormField<String> _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _jenisKelamin,
      decoration: InputDecoration(
        labelText: 'Jenis Kelamin',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: ['Laki-laki', 'Perempuan'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _jenisKelamin = newValue;
        });
      },
      validator: (value) => value == null ? 'Pilih jenis kelamin.' : null,
    );
  }
}