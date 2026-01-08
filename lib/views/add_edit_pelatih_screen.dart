import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pelatih.dart';
import '../providers/pelatih_provider.dart';


class AddEditPelatihScreen extends StatefulWidget {
  const AddEditPelatihScreen({Key? key}) : super(key: key);

  @override
  State<AddEditPelatihScreen> createState() => _AddEditPelatihScreenState();
}

class _AddEditPelatihScreenState extends State<AddEditPelatihScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _cabangOlahragaController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _pengalamanTahunController = TextEditingController();
  String? _jenisKelaminSelected;

  Pelatih? _pelatih;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final pelatihFromArgs = ModalRoute.of(context)?.settings.arguments as Pelatih?;
      if (pelatihFromArgs != null) {
        _pelatih = pelatihFromArgs;
        _namaController.text = _pelatih!.nama;
        _cabangOlahragaController.text = _pelatih!.cabangOlahraga;
        _umurController.text = _pelatih!.umur.toString();
        _pengalamanTahunController.text = _pelatih!.pengalamanTahun.toString();
        _jenisKelaminSelected = _pelatih!.jenisKelamin;
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _cabangOlahragaController.dispose();
    _umurController.dispose();
    _pengalamanTahunController.dispose();
    super.dispose();
  }

  Future<void> _savePelatih() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final pelatihProvider = Provider.of<PelatihProvider>(context, listen: false);

      final newPelatih = Pelatih(
        id: _pelatih?.id,
        nama: _namaController.text,
        cabangOlahraga: _cabangOlahragaController.text,
        umur: int.parse(_umurController.text),
        jenisKelamin: _jenisKelaminSelected!,
        pengalamanTahun: int.parse(_pengalamanTahunController.text),
      );

      bool success;
      String message;
      if (_pelatih == null) {
        success = await pelatihProvider.addPelatih(newPelatih);
        message = success ? 'Pelatih berhasil ditambahkan!' : (pelatihProvider.errorMessage ?? 'Gagal menambahkan pelatih.');
      } else {
        success = await pelatihProvider.updatePelatih(newPelatih);
        message = success ? 'Pelatih berhasil diperbarui!' : (pelatihProvider.errorMessage ?? 'Gagal memperbarui pelatih.');
      }

      if (!mounted) return;

      Notifikasi.show(context, message, isSuccess: success);
      if (success) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pelatih == null ? 'Tambah Pelatih Baru' : 'Edit Pelatih'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextFormField(
                _namaController,
                'Nama Pelatih',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama pelatih tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                _cabangOlahragaController,
                'Cabang Olahraga',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Cabang olahraga tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                _umurController,
                'Umur',
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
              DropdownButtonFormField<String>(
                value: _jenisKelaminSelected,
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
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
              _buildTextFormField(
                _pengalamanTahunController,
                'Pengalaman (tahun)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pengalaman tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 0) {
                    return 'Pengalaman harus angka non-negatif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _savePelatih,
                child: Text(_pelatih == null ? 'Simpan Pelatih' : 'Perbarui Pelatih'),
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
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
