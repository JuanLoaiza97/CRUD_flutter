import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserFormScreen extends StatefulWidget {
  final UserModel? user;
  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String email;

  @override
  void initState() {
    super.initState();
    name = widget.user?.name ?? '';
    email = widget.user?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? "Crear Usuario" : "Editar Usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: "Nombre"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo requerido" : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Campo requerido" : null,
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.user == null) {
                      userProvider.addUser(
                        UserModel(id: 0, name: name, email: email),
                      );
                    } else {
                      userProvider.updateUser(
                        UserModel(id: widget.user!.id, name: name, email: email),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.user == null ? "Guardar" : "Actualizar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
