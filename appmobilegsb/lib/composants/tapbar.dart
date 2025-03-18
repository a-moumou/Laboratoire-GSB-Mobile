import 'package:flutter/material.dart';
import '../homeview.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Nombre d'onglets
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GSB Mobile'),
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
            // Utilisation de HomeView pour l'onglet Accueil
            HomeView(),
            
            // Contenu de l'onglet Rapports
            Center(child: Text('Page Rapports')),
            
            // Contenu de l'onglet Profil
            Center(child: Text('Page Profil')),
          ],
        ),
      ),
    );
  }
}
