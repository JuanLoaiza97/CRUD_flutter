import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  List<UserModel> _users = [];
  bool isLoading = false;

  List<UserModel> get users => _users;

  Future<void> fetchUsers() async {
    isLoading = true;
    notifyListeners();
    _users = await apiService.getUsers();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {
    final newUser = await apiService.createUser(user);
    _users.add(newUser);
    notifyListeners();
  }

  Future<void> updateUser(UserModel user) async {
    final updatedUser = await apiService.updateUser(user);
    int index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = updatedUser;
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    await apiService.deleteUser(id);
    _users.removeWhere((u) => u.id == id);
    notifyListeners();
  }
}
