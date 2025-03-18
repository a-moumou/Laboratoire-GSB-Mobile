import 'package:flutter/material.dart';
import 'loginview.dart';
import 'composants/customtapbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GSB Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 67, 255, 24)),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _checkAuth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData ? const CustomTabBar() : const LoginView();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<bool> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken') != null;
  }
}
