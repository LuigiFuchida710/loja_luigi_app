import 'package:flutter/material.dart';
import 'package:loja_luigi_app/produtos.dart';
import 'package:loja_luigi_app/login.dart';
import 'package:loja_luigi_app/screen/home_screen.dart';
import 'package:loja_luigi_app/services/session_service.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SessionService().estalogado(), 
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return snapshot.data! ? const HomeScreen() : const Login();
      }
      );
  }
}