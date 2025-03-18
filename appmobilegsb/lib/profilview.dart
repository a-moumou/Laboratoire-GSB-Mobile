import 'package:flutter/material.dart';
import 'loginview.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo et nom de l'entreprise
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: Image.asset(
                    'assets/1.png',
                    height: 60,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'GSB Entreprise',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Informations de l'entreprise
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations de l\'entreprise',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text('Nom'),
                    subtitle: Text('GSB - Galaxy Swiss Bourdin'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Adresse'),
                    subtitle: Text('15 rue des Champs-Élysées\n75008 Paris'),
                  ),
                  ListTile(
                    leading: Icon(Icons.numbers),
                    title: Text('SIREN'),
                    subtitle: Text('123 456 789'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Téléphone'),
                    subtitle: Text('+33 1 23 45 67 89'),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('Email'),
                    subtitle: Text('contact@gsb.fr'),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),

          // Bouton de déconnexion
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Déconnexion'),
              onPressed: () {
                // Navigation vers la page de connexion
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
