import 'package:flutter/material.dart';
import '../models/pelatih.dart';
import '../services/pelatih_service.dart';


class PelatihProvider with ChangeNotifier {
  final PelatihService _pelatihService = PelatihService();
  
  List<Pelatih> _pelatihList = [];
  String? _errorMessage;

  List<Pelatih> get pelatihList => _pelatihList;
  String? get errorMessage => _errorMessage;

  Stream<List<Pelatih>> get pelatihStream {
    return _pelatihService.getPelatih().map((snapshot) {
      _pelatihList = snapshot.map((pelatih) => pelatih).toList();
      notifyListeners();
      return _pelatihList;
    });
  }

  Future<bool> addPelatih(Pelatih pelatih) async {
    try {
      await _pelatihService.addPelatih(pelatih);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePelatih(Pelatih pelatih) async {
    try {
      if (pelatih.id == null) {
        throw Exception("Pelatih ID cannot be null for update.");
      }
      await _pelatihService.updatePelatih(pelatih.id!, pelatih);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deletePelatih(String id) async {
    try {
      await _pelatihService.deletePelatih(id);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
