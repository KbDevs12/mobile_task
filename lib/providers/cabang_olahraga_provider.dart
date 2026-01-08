import 'package:flutter/material.dart';
import '../models/cabang_olahraga.dart';
import '../services/cabang_olahraga.dart'; // Correct import
import 'package:cloud_firestore/cloud_firestore.dart'; // For DocumentSnapshot

class CabangOlahragaProvider with ChangeNotifier {
  final CabangOlahragaService _cabangOlahragaService = CabangOlahragaService();
  
  List<CabangOlahraga> _cabangOlahragaList = [];
  String? _errorMessage;

  List<CabangOlahraga> get cabangOlahragaList => _cabangOlahragaList;
  String? get errorMessage => _errorMessage;

  Stream<List<CabangOlahraga>> get cabangOlahragaStream {
    return _cabangOlahragaService.getCabang().map((snapshot) {
      _cabangOlahragaList = snapshot.docs.map((doc) => CabangOlahraga.fromFirestore(doc)).toList();
      notifyListeners();
      return _cabangOlahragaList;
    });
  }

  Future<bool> addCabangOlahraga(CabangOlahraga cabangOlahraga) async {
    try {
      await _cabangOlahragaService.addCabang(cabangOlahraga);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCabangOlahraga(CabangOlahraga cabangOlahraga) async {
    try {
      if (cabangOlahraga.id == null) {
        throw Exception("CabangOlahraga ID cannot be null for update.");
      }
      await _cabangOlahragaService.updateCabang(cabangOlahraga.id!, cabangOlahraga);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCabangOlahraga(String id) async {
    try {
      await _cabangOlahragaService.deleteCabang(id);
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
