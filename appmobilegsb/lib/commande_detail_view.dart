import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommandeDetailView extends StatefulWidget {
  final String commandeId;

  const CommandeDetailView({super.key, required this.commandeId});

  @override
  _CommandeDetailViewState createState() => _CommandeDetailViewState();
}

class _CommandeDetailViewState extends State<CommandeDetailView> {
  Map<String, dynamic>? commande;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCommandeDetails();
  }

  Future<void> fetchCommandeDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://VOTRE_IP:3000/api/commandes/${widget.commandeId}'),
      );

      if (response.statusCode == 200) {
        setState(() {
          commande = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Erreur de chargement des détails');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erreur: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erreur')),
        body: Center(child: Text(errorMessage)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(commande!['reference'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Statut: ${commande!['statut']}', 
                 style: const TextStyle(fontSize: 18)),
            Text('Date: ${commande!['date']}'),
            const SizedBox(height: 20),
            const Text('Historique:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...commande!['historique'].map<Widget>((etape) => ListTile(
              title: Text(etape['statut']),
              subtitle: Text(etape['date']),
            )).toList(),
          ],
        ),
      ),
    );
  }
} 