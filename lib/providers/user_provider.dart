import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<UserModel> _users = [];
  bool isLoading = false;

  List<UserModel> get users => _users;

  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();
    try {
      _users = await apiService.fetchUsers();
    } catch (e) {
      _users = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUser(UserModel user) async {
    final newUser = await apiService.createUser(user);
    _users.add(newUser);
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    final updated = await apiService.updateUser(user);
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = updated;
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    await apiService.deleteUser(id);
    _users.removeWhere((u) => u.id == id);
    notifyListeners();
  }
}
