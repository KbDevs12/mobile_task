import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../models/atlet.dart';
import '../providers/atlet_provider.dart'; // Import AtletProvider
import '../utils/notifikasi.dart';


// Layar untuk menambah atau mengedit data atlet
class AddEditAtletScreen extends StatefulWidget {
  const AddEditAtletScreen({Key? key}) : super(key: key);

  @override
  State<AddEditAtletScreen> createState() => _AddEditAtletScreenState();
}

class _AddEditAtletScreenState extends State<AddEditAtletScreen> {
  final _formKey = GlobalKey<FormState>(); // Kunci untuk validasi form

  // Controller untuk setiap input field
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _cabangAtletController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _beratBadanController = TextEditingController();
  final TextEditingController _tinggiBadanController = TextEditingController();
  String? _jenisKelaminSelected;

  Atlet? _atlet;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final atletFromArgs = ModalRoute.of(context)?.settings.arguments as Atlet?;
      if (atletFromArgs != null) {
        _atlet = atletFromArgs;
        // Inisialisasi controller dengan data atlet jika sedang dalam mode edit
        _namaController.text = _atlet!.nama;
        _cabangAtletController.text = _atlet!.cabangAtlet;
        _umurController.text = _atlet!.umur.toString();
        _beratBadanController.text = _atlet!.beratBadan.toString();
        _tinggiBadanController.text = _atlet!.tinggiBadan.toString();
        _jenisKelaminSelected = _atlet!.jenisKelamin;
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget di-dispose
    _namaController.dispose();
    _cabangAtletController.dispose();
    _umurController.dispose();
    _beratBadanController.dispose();
    _tinggiBadanController.dispose();
    super.dispose();
  }

  // Fungsi untuk menyimpan data atlet
  Future<void> _saveAtlet() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final atletProvider = Provider.of<AtletProvider>(context, listen: false);

      final newAtlet = Atlet(
        id: _atlet?.id, // Pertahankan ID jika update
        nama: _namaController.text,
        cabangAtlet: _cabangAtletController.text,
        umur: int.parse(_umurController.text),
        jenisKelamin: _jenisKelaminSelected!,
        beratBadan: double.parse(_beratBadanController.text),
        tinggiBadan: double.parse(_tinggiBadanController.text),
      );

      bool success;
      String message;
      if (_atlet == null) {
        // Menambah atlet baru
        success = await atletProvider.addAtlet(newAtlet);
        message = success ? 'Atlet berhasil ditambahkan!' : (atletProvider.errorMessage ?? 'Gagal menambahkan atlet.');
      } else {
        // Mengedit atlet yang sudah ada
        success = await atletProvider.updateAtlet(newAtlet);
        message = success ? 'Atlet berhasil diperbarui!' : (atletProvider.errorMessage ?? 'Gagal memperbarui atlet.');
      }

      if (!mounted) return; // Periksa apakah widget masih dalam tree

      Notifikasi.show(context, message, isSuccess: success); // Tampilkan notifikasi
      if (success) {
        Navigator.pop(context); // Kembali ke layar sebelumnya jika berhasil
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_atlet == null ? 'Tambah Atlet Baru' : 'Edit Atlet'),
        // backgroundColor dan foregroundColor sudah diatur di tema utama (main.dart)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Input Nama
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Atlet',
                  // Border diatur di inputDecorationTheme global
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama atlet tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Input Cabang Atlet
              TextFormField(
                controller: _cabangAtletController,
                decoration: const InputDecoration(
                  labelText: 'Cabang Atlet',
                  // Border diatur di inputDecorationTheme global
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Cabang atlet tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Input Umur
              TextFormField(
                controller: _umurController,
                decoration: const InputDecoration(
                  labelText: 'Umur',
                  // Border diatur di inputDecorationTheme global
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Umur tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Umur harus angka positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Dropdown Jenis Kelamin
              DropdownButtonFormField<String>(
                value: _jenisKelaminSelected,
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  // Border diatur di inputDecorationTheme global
                ),
                items: <String>['Laki-laki', 'Perempuan'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _jenisKelaminSelected = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih jenis kelamin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Input Berat Badan
              TextFormField(
                controller: _beratBadanController,
                decoration: const InputDecoration(
                  labelText: 'Berat Badan (kg)',
                  // Border diatur di inputDecorationTheme global
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Berat badan tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Berat badan harus angka positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Input Tinggi Badan
              TextFormField(
                controller: _tinggiBadanController,
                decoration: const InputDecoration(
                  labelText: 'Tinggi Badan (cm)',
                  // Border diatur di inputDecorationTheme global
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tinggi badan tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Tinggi badan harus angka positif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Tombol Simpan
              ElevatedButton(
                onPressed: _saveAtlet,
                // Style sudah diatur di ElevatedButtonThemeData global
                child: Text(_atlet == null ? 'Simpan Atlet' : 'Perbarui Atlet'),
              ),
            ],
          ),
        ),
      ),
    );
  }


}