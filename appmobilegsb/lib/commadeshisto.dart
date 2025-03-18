import 'package:flutter/material.dart';

class CommandesHistoView extends StatelessWidget {
  const CommandesHistoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des Commandes'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Résumé des commandes
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      'En cours',
                      '3',
                      Colors.blue,
                      Icons.pending_actions,
                    ),
                    _buildStatCard(
                      'Livrées',
                      '28',
                      Colors.green,
                      Icons.check_circle,
                    ),
                    _buildStatCard(
                      'Annulées',
                      '2',
                      Colors.red,
                      Icons.cancel,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Filtres
            Row(
              children: [
                const Text(
                  'Historique',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                DropdownButton<String>(
                  value: 'Tous',
                  items: ['Tous', 'En cours', 'Livrées', 'Annulées']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // TODO: Implémenter le filtrage
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Liste des commandes
            _buildCommandeCard(
              'CMD-2024-001',
              'En cours de livraison',
              '1 250,00 €',
              '15/02/2024',
              Icons.local_shipping,
              Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildCommandeCard(
              'CMD-2024-002',
              'En préparation',
              '850,30 €',
              '14/02/2024',
              Icons.pending,
              Colors.orange,
            ),
            const SizedBox(height: 8),
            _buildCommandeCard(
              'CMD-2024-003',
              'Livrée',
              '2 150,80 €',
              '10/02/2024',
              Icons.check_circle,
              Colors.green,
            ),
            const SizedBox(height: 8),
            _buildCommandeCard(
              'CMD-2024-004',
              'Annulée',
              '750,00 €',
              '05/02/2024',
              Icons.cancel,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildCommandeCard(
    String reference,
    String status,
    String montant,
    String date,
    IconData icon,
    Color statusColor,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: statusColor),
        title: Text(reference),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(date),
            Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Text(
          montant,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          // TODO: Afficher les détails de la commande
        },
      ),
    );
  }
}
