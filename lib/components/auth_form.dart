import 'dart:io';

import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

import 'user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({required this.onSubmit, super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void handleImagePick(File image) {
    _authFormData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    if (_authFormData.image == null && _authFormData.isSignup) {
      return _showError('Imagem não selecionada!');
    }

    widget.onSubmit(_authFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authFormData.isSignup)
                UserImagePicker(
                  onImagePick: handleImagePick,
                ),
              if (_authFormData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _authFormData.name,
                  onChanged: (name) => _authFormData.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (_name) {
                    final name = _name ?? '';

                    if (name.trim().isEmpty) return 'Nome é obrigatório';
                    if (name.trim().length <= 4) {
                      return 'Nome precisa ter mais de 4 caracteres';
                    }

                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _authFormData.email,
                onChanged: (email) => _authFormData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (_email) {
                  final email = _email ?? "";

                  if (email.trim().isEmpty) return 'Email é obrigatório';
                  if (!email.contains('@')) return 'Email inválido';

                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _authFormData.password,
                onChanged: (password) => _authFormData.password = password,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (_password) {
                  final password = _password ?? '';

                  if (password.isEmpty) return 'Senha é obrigatório';
                  if (password.trim().length <= 8) {
                    return 'Senha precisa ter pelo menos 8 caracteres';
                  }

                  return null;
                },
              ),
              const SizedBox(
                width: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_authFormData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authFormData.toggleAuthMode();
                  });
                },
                child: Text(
                  _authFormData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
