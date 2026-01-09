import 'package:flutter/material.dart';
import 'package:tugas_mobile/models/pelatih.dart';
import 'package:tugas_mobile/services/pelatih_service.dart';
import 'package:tugas_mobile/utils/notifikasi.dart';
import 'package:tugas_mobile/widgets/gradient_app_bar.dart';
import 'package:tugas_mobile/widgets/gradient_button.dart';

class AddEditPelatihScreen extends StatefulWidget {
  final Pelatih? pelatih;
  final PelatihService pelatihService;

  const AddEditPelatihScreen({
    super.key,
    this.pelatih,
    required this.pelatihService,
  });

  @override
  State<AddEditPelatihScreen> createState() => _AddEditPelatihScreenState();
}

class _AddEditPelatihScreenState extends State<AddEditPelatihScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _umurController;
  late TextEditingController _pengalamanTahunController;
  String? _jenisKelamin;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.pelatih?.nama);
    // Removed initialization of _cabangOlahragaController
    _umurController = TextEditingController(
      text: widget.pelatih?.umur.toString(),
    );
    _pengalamanTahunController = TextEditingController(
      text: widget.pelatih?.pengalamanTahun.toString(),
    );
    _jenisKelamin = widget.pelatih?.jenisKelamin;
  }

  @override
  void dispose() {
    _namaController.dispose();
    // Removed disposal of _cabangOlahragaController
    _umurController.dispose();
    _pengalamanTahunController.dispose();
    super.dispose();
  }

  void _savePelatih() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final newPelatih = Pelatih(
          id: widget.pelatih?.id,
          nama: _namaController.text,
          cabangOlahraga: '',
          umur: int.parse(_umurController.text),
          jenisKelamin: _jenisKelamin!,
          pengalamanTahun: int.parse(_pengalamanTahunController.text),
        );

        if (widget.pelatih == null) {
          await widget.pelatihService.addPelatih(newPelatih);
          if (context.mounted)
            Notifikasi.show(context, 'Pelatih berhasil ditambahkan.');
        } else {
          await widget.pelatihService.updatePelatih(
            widget.pelatih!.id!,
            newPelatih,
          );
          if (context.mounted)
            Notifikasi.show(context, 'Data pelatih berhasil diperbarui.');
        }

        if (context.mounted) Navigator.pop(context);
      } catch (e) {
        setState(() => _isLoading = false);
        if (context.mounted)
          Notifikasi.show(context, 'Gagal menyimpan: $e', isSuccess: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: widget.pelatih == null
            ? 'Tambah Pelatih'
            : 'Edit Pelatih', // Dynamic title
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
              // Removed _buildTextFormField(_cabangOlahragaController, 'Cabang Olahraga'),
              const SizedBox(height: 16),
              _buildTextFormField(
                _umurController,
                'Umur',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildGenderDropdown(),
              const SizedBox(height: 16),
              _buildTextFormField(
                _pengalamanTahunController,
                'Pengalaman (tahun)',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),
              GradientButton(
                onPressed: _isLoading ? null : _savePelatih,
                // height: 50, // Example height if needed
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
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
        if (keyboardType == TextInputType.number &&
            int.tryParse(value) == null) {
          return 'Masukkan angka yang valid.';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField<String> _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _jenisKelamin,
      decoration: InputDecoration(
        labelText: 'Jenis Kelamin',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: ['Laki-laki', 'Perempuan'].map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
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
