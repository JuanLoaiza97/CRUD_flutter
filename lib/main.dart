import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider()..fetchUsers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter CRUD',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const UserListScreen(),
      ),
    );
  }
}