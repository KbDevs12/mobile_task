import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/cabang_olahraga.dart';
import 'package:tugas_mobile/services/cabang_olahraga.dart';
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
  late TextEditingController _kategoriController;
  late TextEditingController _tingkatController;
  late TextEditingController _jumlahAtletController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _namaCabangController = TextEditingController(text: widget.cabangOlahraga?.namaCabang);
    _kategoriController = TextEditingController(text: widget.cabangOlahraga?.kategori);
    _tingkatController = TextEditingController(text: widget.cabangOlahraga?.tingkat);
    _jumlahAtletController = TextEditingController(text: widget.cabangOlahraga?.jumlahAtlet.toString());
  }

  @override
  void dispose() {
    _namaCabangController.dispose();
    _kategoriController.dispose();
    _tingkatController.dispose();
    _jumlahAtletController.dispose();
    super.dispose();
  }

  void _saveCabangOlahraga() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final newCabangOlahraga = CabangOlahraga(
          id: widget.cabangOlahraga?.id,
          namaCabang: _namaCabangController.text,
          kategori: _kategoriController.text,
          tingkat: _tingkatController.text,
          jumlahAtlet: int.parse(_jumlahAtletController.text),
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
              _buildTextFormField(_kategoriController, 'Kategori'),
              const SizedBox(height: 16),
              _buildTextFormField(_tingkatController, 'Tingkat'),
              const SizedBox(height: 16),
              _buildTextFormField(_jumlahAtletController, 'Jumlah Atlet', keyboardType: TextInputType.number),
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