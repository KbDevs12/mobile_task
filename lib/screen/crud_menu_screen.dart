import 'package:flutter/material.dart';

class CrudMenuScreen extends StatelessWidget {
  const CrudMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu CRUD'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuCard(
            context,
            icon: Icons.people_outline,
            title: 'Atlet',
            subtitle: 'Kelola data para atlet',
            routeName: '/atlet-list',
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            icon: Icons.person_search_outlined,
            title: 'Pelatih',
            subtitle: 'Kelola data para pelatih',
            routeName: '/pelatih-list',
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          _buildMenuCard(
            context,
            icon: Icons.sports_kabaddi_outlined,
            title: 'Cabang Olahraga',
            subtitle: 'Kelola data cabang olahraga',
            routeName: '/cabang-olahraga-list',
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String routeName,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shadowColor: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
