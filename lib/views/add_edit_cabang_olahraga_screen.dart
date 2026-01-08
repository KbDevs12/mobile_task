import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/cabang_olahraga.dart';
import 'package:tugas_mobile/models/pelatih.dart'; // Import Pelatih model
import 'package:tugas_mobile/services/cabang_olahraga.dart';
import 'package:tugas_mobile/services/pelatih_service.dart'; // Import PelatihService
import 'package:tugas_mobile/utils/notifikasi.dart';

class AddEditCabangOlahragaScreen extends StatefulWidget {
  final CabangOlahraga? cabangOlahraga;
  final CabangOlahragaService cabangOlahragaService;

  const AddEditCabangOlahragaScreen({
    super.key,
    this.cabangOlahraga,
    required this.cabangOlahragaService,
  });

  @override
  State<AddEditCabangOlahragaScreen> createState() => _AddEditCabangOlahragaScreenState();
}

class _AddEditCabangOlahragaScreenState extends State<AddEditCabangOlahragaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaCabangController;
  // Removed _kategoriController, _tingkatController, _jumlahAtletController
  String? _selectedPelatihId; // To store selected Pelatih ID
  String? _selectedPelatihNama; // To store selected Pelatih Name

  final PelatihService _pelatihService = PelatihService(); // Instantiate PelatihService

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _namaCabangController = TextEditingController(text: widget.cabangOlahraga?.namaCabang);
    // Removed initialization of _kategoriController, _tingkatController, _jumlahAtletController
    _selectedPelatihId = widget.cabangOlahraga?.pelatihId; // Initialize for edit mode
    _selectedPelatihNama = widget.cabangOlahraga?.pelatihNama; // Initialize for edit mode
  }

  @override
  void dispose() {
    _namaCabangController.dispose();
    // Removed disposal of _kategoriController, _tingkatController, _jumlahAtletController
    super.dispose();
  }

  void _saveCabangOlahraga() async {
    if (_formKey.currentState!.validate()) {
      // Ensure a trainer is selected
      if (_selectedPelatihId == null || _selectedPelatihNama == null) {
        if (context.mounted) Notifikasi.show(context, 'Pilih pelatih untuk cabang olahraga ini.', isSuccess: false);
        return;
      }

      setState(() => _isLoading = true);

      try {
        final newCabangOlahraga = CabangOlahraga(
          id: widget.cabangOlahraga?.id,
          namaCabang: _namaCabangController.text,
          pelatihId: _selectedPelatihId,
          pelatihNama: _selectedPelatihNama!,
        );

        if (widget.cabangOlahraga == null) {
          await widget.cabangOlahragaService.addCabang(newCabangOlahraga);
          if (context.mounted) Notifikasi.show(context, 'Cabang olahraga berhasil ditambahkan.');
        } else {
          await widget.cabangOlahragaService.updateCabang(widget.cabangOlahraga!.id!, newCabangOlahraga);
          if (context.mounted) Notifikasi.show(context, 'Data cabang olahraga berhasil diperbarui.');
        }

        if (context.mounted) Navigator.pop(context);
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
        title: Text(widget.cabangOlahraga == null ? 'Tambah Cabang Olahraga' : 'Edit Cabang Olahraga'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextFormField(_namaCabangController, 'Nama Cabang'),
              const SizedBox(height: 16),
              // Removed _buildTextFormField(_kategoriController, 'Kategori'),
              // const SizedBox(height: 16),
              // Removed _buildTextFormField(_tingkatController, 'Tingkat'),
              // const SizedBox(height: 16),
              // Removed _buildTextFormField(_jumlahAtletController, 'Jumlah Atlet', keyboardType: TextInputType.number),
              // const SizedBox(height: 16),
              StreamBuilder<List<Pelatih>>(
                stream: _pelatihService.getPelatih(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Tidak ada pelatih tersedia. Tambahkan pelatih terlebih dahulu.');
                  }

                  final List<Pelatih> pelatihList = snapshot.data!;
                  return DropdownButtonFormField<String>(
                    value: _selectedPelatihId,
                    decoration: InputDecoration(
                      labelText: 'Pilih Pelatih',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    items: pelatihList.map<DropdownMenuItem<String>>((Pelatih pelatih) {
                      return DropdownMenuItem<String>(
                        value: pelatih.id,
                        child: Text(pelatih.nama),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPelatihId = newValue;
                        _selectedPelatihNama = pelatihList.firstWhere((p) => p.id == newValue).nama;
                      });
                    },
                    validator: (value) => value == null ? 'Pilih pelatih.' : null,
                  );
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveCabangOlahraga,
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
        if (keyboardType == TextInputType.number && int.tryParse(value) == null) {
          return 'Masukkan angka yang valid.';
        }
        return null;
      },
    );
  }
}