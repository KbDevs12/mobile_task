import 'package:flutter/material.dart';
import '../models/atlet.dart'; // Ensure this path is correct
import '../services/firestore_service.dart'; // Ensure this path is correct

class AtletProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<Atlet> _atlets = [];
  String? _errorMessage;

  List<Atlet> get atlets => _atlets;
  String? get errorMessage => _errorMessage;

  Stream<List<Atlet>> get atletsStream {
    return _firestoreService.getAtlets().map((snapshot) {
      _atlets = snapshot.docs.map((doc) => Atlet.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
      notifyListeners();
      return _atlets;
    });
  }

  Future<bool> addAtlet(Atlet atlet) async {
    try {
      await _firestoreService.addAtlet(atlet.toMap());
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateAtlet(Atlet atlet) async {
    try {
      if (atlet.id == null) {
        throw Exception("Atlet ID cannot be null for update.");
      }
      await _firestoreService.updateAtlet(atlet.id!, atlet.toMap());
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteAtlet(String id) async {
    try {
      await _firestoreService.deleteAtlet(id);
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
