import 'package:chat/components/auth_form.dart';
import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthFormData _authformData = AuthFormData();
  bool isLoading = false;

  void handleSubmit(AuthFormData data) {
    setState(() {
      isLoading = true;
    });

    _authformData.email = data.email;
    _authformData.image = data.image;
    _authformData.name = data.name;
    _authformData.password = data.password;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: handleSubmit),
            ),
          ),
          if (isLoading)
            Container(
              decoration: const BoxDecoration(
                color:  Color.fromRGBO(0, 0, 0, 0.5)
              ),
              child: const Center(
                child: CircularProgressIndicator(
                    // color: Colors.black,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
