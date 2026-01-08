import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cabang_olahraga.dart';
import '../providers/cabang_olahraga_provider.dart';


class AddEditCabangOlahragaScreen extends StatefulWidget {
  const AddEditCabangOlahragaScreen({Key? key}) : super(key: key);

  @override
  State<AddEditCabangOlahragaScreen> createState() => _AddEditCabangOlahragaScreenState();
}

class _AddEditCabangOlahragaScreenState extends State<AddEditCabangOlahragaScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaCabangController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _tingkatController = TextEditingController();
  final TextEditingController _jumlahAtletController = TextEditingController();

  CabangOlahraga? _cabangOlahraga;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final cabangOlahragaFromArgs = ModalRoute.of(context)?.settings.arguments as CabangOlahraga?;
      if (cabangOlahragaFromArgs != null) {
        _cabangOlahraga = cabangOlahragaFromArgs;
        _namaCabangController.text = _cabangOlahraga!.namaCabang;
        _kategoriController.text = _cabangOlahraga!.kategori;
        _tingkatController.text = _cabangOlahraga!.tingkat;
        _jumlahAtletController.text = _cabangOlahraga!.jumlahAtlet.toString();
      }
    }
    _isInit = false;
  }

  @override
  void dispose() {
    _namaCabangController.dispose();
    _kategoriController.dispose();
    _tingkatController.dispose();
    _jumlahAtletController.dispose();
    super.dispose();
  }

  Future<void> _saveCabangOlahraga() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final cabangOlahragaProvider = Provider.of<CabangOlahragaProvider>(context, listen: false);

      final newCabangOlahraga = CabangOlahraga(
        id: _cabangOlahraga?.id,
        namaCabang: _namaCabangController.text,
        kategori: _kategoriController.text,
        tingkat: _tingkatController.text,
        jumlahAtlet: int.parse(_jumlahAtletController.text),
      );

      bool success;
      String message;
      if (_cabangOlahraga == null) {
        success = await cabangOlahragaProvider.addCabangOlahraga(newCabangOlahraga);
        message = success ? 'Cabang olahraga berhasil ditambahkan!' : (cabangOlahragaProvider.errorMessage ?? 'Gagal menambahkan cabang olahraga.');
      } else {
        success = await cabangOlahragaProvider.updateCabangOlahraga(newCabangOlahraga);
        message = success ? 'Cabang olahraga berhasil diperbarui!' : (cabangOlahragaProvider.errorMessage ?? 'Gagal memperbarui cabang olahraga.');
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
        title: Text(_cabangOlahraga == null ? 'Tambah Cabang Olahraga Baru' : 'Edit Cabang Olahraga'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextFormField(
                _namaCabangController,
                'Nama Cabang Olahraga',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama cabang olahraga tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                _kategoriController,
                'Kategori',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                _tingkatController,
                'Tingkat (e.g., Nasional, Provinsi, Kota)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tingkat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                _jumlahAtletController,
                'Jumlah Atlet',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah atlet tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 0) {
                    return 'Jumlah atlet harus angka non-negatif';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveCabangOlahraga,
                child: Text(_cabangOlahraga == null ? 'Simpan Cabang Olahraga' : 'Perbarui Cabang Olahraga'),
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
