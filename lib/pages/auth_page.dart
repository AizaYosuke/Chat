import 'package:chat/components/auth_form.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // final AuthFormData _authformData = AuthFormData();
  bool isLoading = false;

  Future<void> handleSubmit(AuthFormData data) async {
    try {
      setState(() {
        isLoading = true;

        if (data.isLogin) {
          AuthService().login(data.email, data.password);
        } else {
          AuthService().signup(
            data.name,
            data.email,
            data.password,
            data.image,
          );
        }
      });
    } catch (e) {
      // TODO: error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
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
