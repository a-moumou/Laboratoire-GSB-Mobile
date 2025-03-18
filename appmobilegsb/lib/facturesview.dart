import 'package:flutter/material.dart';

class FacturesView extends StatelessWidget {
  const FacturesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Factures'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec total
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Total des factures',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '15 230,50 €',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
  
            // Liste des factures
            const Text(
              'Historique des factures',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildFactureCard(
              'FAC-2024-001',
              '3 250,00 €',
              'Payée',
              '15/01/2024',
              Colors.green,
            ),
            const SizedBox(height: 8),
            _buildFactureCard(
              'FAC-2024-002',
              '1 875,30 €',
              'En attente',
              '28/01/2024',
              Colors.orange,
            ),
            const SizedBox(height: 8),
            _buildFactureCard(
              'FAC-2024-003',
              '2 450,80 €',
              'En retard',
              '05/02/2024',
              Colors.red,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implémenter l'ajout d'une nouvelle facture
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFactureCard(
    String reference,
    String montant,
    String statut,
    String date,
    Color statusColor,
  ) {
    return Card(
      child: ListTile(
        title: Text(reference),
        subtitle: Text(date),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              montant,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              statut,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          // TODO: Afficher les détails de la facture
        },
      ),
    );
  }
}
