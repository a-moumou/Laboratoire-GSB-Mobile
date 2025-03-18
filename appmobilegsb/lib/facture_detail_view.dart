import 'package:flutter/material.dart';

class FactureDetailView extends StatelessWidget {
  final Map<String, dynamic> facture;

  const FactureDetailView({super.key, required this.facture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(facture['reference'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Référence', facture['reference']),
            _buildDetailRow('Montant', '${facture['montant']} €'),
            _buildDetailRow('Statut', facture['statut']),
            _buildDetailRow('Date', facture['date']),
            _buildDetailRow('Client', facture['client']),
            const SizedBox(height: 20),
            const Text('Articles:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ...facture['articles'].map<Widget>((article) => ListTile(
                  title: Text(article['nom']),
                  trailing: Text('${article['quantité']} unités'),
                )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
} 