import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/atlet.dart';
import 'package:tugas_mobile/models/cabang_olahraga.dart'; // Import CabangOlahraga model
import 'package:tugas_mobile/services/atlet_service.dart';
import 'package:tugas_mobile/services/cabang_olahraga.dart'; // Import CabangOlahragaService
import 'package:tugas_mobile/utils/notifikasi.dart';
import 'package:tugas_mobile/widgets/gradient_app_bar.dart'; // Import GradientAppBar
import 'package:tugas_mobile/widgets/gradient_button.dart'; // Import GradientButton

// Halaman ini berfungsi untuk menambah atau mengedit data atlet.
class AddEditAtletScreen extends StatefulWidget {
  // Atlet opsional, jika ada berarti mode 'Edit', jika null berarti mode 'Tambah'.
  final Atlet? atlet;
  final AtletService atletService;

  const AddEditAtletScreen({super.key, this.atlet, required this.atletService});

  @override
  State<AddEditAtletScreen> createState() => _AddEditAtletScreenState();
}

class _AddEditAtletScreenState extends State<AddEditAtletScreen> {
  // Kunci global untuk form, digunakan untuk validasi.
  final _formKey = GlobalKey<FormState>();

  // Controller untuk setiap input field.
  late TextEditingController _namaController;
  // Removed _cabangController, replaced by dropdown selection
  late TextEditingController _umurController;
  late TextEditingController _beratController;
  late TextEditingController _tinggiController;
  String? _jenisKelamin; // Variabel untuk menyimpan pilihan dropdown.

  String? _selectedCabangOlahragaId; // To store selected CabangOlahraga ID
  String? _selectedCabangOlahragaNama; // To store selected CabangOlahraga display name

  final AtletService _atletService;
  final CabangOlahragaService _cabangOlahragaService = CabangOlahragaService(); // Instantiate CabangOlahragaService

  // Flag untuk menandai apakah sedang dalam proses loading.
  bool _isLoading = false;

  _AddEditAtletScreenState() : _atletService = AtletService(); // Initialize AtletService

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.atlet?.nama);
    _umurController = TextEditingController(text: widget.atlet?.umur.toString());
    _beratController = TextEditingController(text: widget.atlet?.beratBadan.toString());
    _tinggiController = TextEditingController(text: widget.atlet?.tinggiBadan.toString());
    _jenisKelamin = widget.atlet?.jenisKelamin;

    _selectedCabangOlahragaId = widget.atlet?.cabangOlahragaId; // Initialize for edit mode
    _selectedCabangOlahragaNama = widget.atlet?.cabangOlahragaNama; // Initialize for edit mode
  }

  @override
  void dispose() {
    // Selalu dispose controller setelah tidak digunakan untuk menghindari memory leak.
    _namaController.dispose();
    _umurController.dispose();
    _beratController.dispose();
    _tinggiController.dispose();
    super.dispose();
  }

  // Method untuk menyimpan atau memperbarui data.
  void _saveAtlet() async {
    // Validasi form terlebih dahulu.
    if (_formKey.currentState!.validate()) {
      // Ensure a sports branch is selected
      if (_selectedCabangOlahragaId == null || _selectedCabangOlahragaNama == null) {
        if (context.mounted) Notifikasi.show(context, 'Pilih cabang olahraga untuk atlet ini.', isSuccess: false);
        return;
      }

      setState(() => _isLoading = true);

      try {
        final atletBaru = Atlet(
          id: widget.atlet?.id, // ID tetap jika mode 'Edit'.
          nama: _namaController.text,
          cabangAtlet: _selectedCabangOlahragaNama!, // Use the formatted display name
          umur: int.parse(_umurController.text),
          jenisKelamin: _jenisKelamin!,
          beratBadan: double.parse(_beratController.text),
          tinggiBadan: double.parse(_tinggiController.text),
          cabangOlahragaId: _selectedCabangOlahragaId,
          cabangOlahragaNama: _selectedCabangOlahragaNama!,
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
      appBar: GradientAppBar(
        title: widget.atlet == null ? 'Tambah Atlet' : 'Edit Atlet', // Dynamic title
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
              // Replaced _buildTextFormField(_cabangController, 'Cabang Atlet') with Dropdown
              StreamBuilder<List<CabangOlahraga>>(
                stream: _cabangOlahragaService.getCabang(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Tidak ada cabang olahraga tersedia. Tambahkan cabang olahraga terlebih dahulu.');
                  }

                  final List<CabangOlahraga> cabangOlahragaList = snapshot.data!;
                  return DropdownButtonFormField<String>(
                    value: _selectedCabangOlahragaId,
                    decoration: InputDecoration(
                      labelText: 'Pilih Cabang Olahraga',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    items: cabangOlahragaList.map<DropdownMenuItem<String>>((CabangOlahraga cabangOlahraga) {
                      return DropdownMenuItem<String>(
                        value: cabangOlahraga.id,
                        child: Text('${cabangOlahraga.namaCabang} - ${cabangOlahraga.pelatihNama}'), // Display format
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCabangOlahragaId = newValue;
                        final selectedCabang = cabangOlahragaList.firstWhere((c) => c.id == newValue);
                        _selectedCabangOlahragaNama = '${selectedCabang.namaCabang} - ${selectedCabang.pelatihNama}';
                      });
                    },
                    validator: (value) => value == null ? 'Pilih cabang olahraga.' : null,
                  );
                },
              ),
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
              GradientButton(
                onPressed: _isLoading ? null : _saveAtlet,
                // height: 50, // Example height if needed
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