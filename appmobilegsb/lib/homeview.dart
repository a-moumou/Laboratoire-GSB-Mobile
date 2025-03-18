import 'package:flutter/material.dart';
import 'facturesview.dart';
import 'commadeshisto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'facture_detail_view.dart';
import 'commande_detail_view.dart';
import 'services/api_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ApiService _apiService = ApiService();
  List<dynamic> factures = [];
  List<dynamic> commandes = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final facturesData = await _apiService.get('factures');
      final commandesData = await _apiService.get('commandes');

      if (mounted) {
        setState(() {
          factures = facturesData;
          commandes = commandesData;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erreur de connexion à l\'API: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Factures
          const Text(
            'Mes Dernières Factures',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...factures.map((facture) => _buildFactureCard(facture)).toList(),

          const SizedBox(height: 32),

          // Section Commandes
          const Text(
            'Suivi des Commandes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...commandes.map((commande) => _buildCommandeCard(commande)).toList(),
        ],
      ),
    );
  }

  Widget _buildFactureCard(Map<String, dynamic> facture) {
    return Card(
      child: ListTile(
        title: Text(facture['reference']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Montant: ${facture['montant']} €'),
            Text('Statut: ${facture['statut']}'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FactureDetailView(facture: facture),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommandeCard(Map<String, dynamic> commande) {
    return Card(
      child: ListTile(
        leading: _getStatusIcon(commande['statut']),
        title: Text(commande['reference']),
        subtitle: Text('Statut: ${commande['statut']}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommandeDetailView(commandeId: commande['id']),
            ),
          );
        },
      ),
    );
  }

  Icon _getStatusIcon(String statut) {
    switch (statut.toLowerCase()) {
      case 'expédiée':
        return const Icon(Icons.local_shipping, color: Colors.green);
      case 'en préparation':
        return const Icon(Icons.build, color: Colors.orange);
      default:
        return const Icon(Icons.pending, color: Colors.grey);
    }
  }
}
