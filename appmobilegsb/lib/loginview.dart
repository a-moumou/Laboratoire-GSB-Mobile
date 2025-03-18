import 'dart:io';
import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'composants/customtapbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await _apiService.post('login', {
          'email': _emailController.text,
          'password': _passwordController.text
        });
        
        print('Réponse brute: $response');
        
        if (response['token'] != null) {
          print('Token reçu: ${response['token']}');
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('authToken', response['token']);
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CustomTabBar()),
          );
        }
      } catch (e) {
        print('Erreur API: $e'); // Debug
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Erreur'),
            content: Text(e is SocketException 
                ? 'Pas de connexion Internet'
                : 'Échec de la connexion: ${e.toString()}'),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Image.asset(
                  'assets/1.png',
                  height: 300,
                ),

              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
