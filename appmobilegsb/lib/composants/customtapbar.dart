import 'package:flutter/material.dart';
import '../homeview.dart';
import '../profilview.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

 @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/science.png',
            height: 150, // Ajustez la hauteur selon vos besoins
            fit: BoxFit.contain,
          ),
          centerTitle: true, // Centre le logo
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Accueil',
              ),
              Tab(
                icon: Icon(Icons.article),
                text: 'Rapports',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profil',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            Center(child: Text('Page Rapports')),
            ProfilView(),
          ],
        ),
      ),
    );
  }
} 