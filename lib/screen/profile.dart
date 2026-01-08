import 'package:flutter/material.dart';
import 'package:tugas_mobile/widgets/gradient_button.dart'; // Import GradientButton

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1), // Use theme color
            child: Icon(Icons.person, size: 60, color: Theme.of(context).colorScheme.primary), // Use theme color
          ),
          SizedBox(height: 12),
          Text(
            'Dava Ananda',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold), // Use theme typography
          ),
          SizedBox(height: 4),
          Text('Admin Atlet', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
          SizedBox(height: 20),
          Card(
            // Card theme is applied globally in main.dart
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.email, color: Theme.of(context).colorScheme.onSurface),
                  title: Text('Email', style: Theme.of(context).textTheme.bodyLarge),
                  subtitle: Text('dava@email.com', style: Theme.of(context).textTheme.bodyMedium),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.phone, color: Theme.of(context).colorScheme.onSurface),
                  title: Text('No. HP', style: Theme.of(context).textTheme.bodyLarge),
                  subtitle: Text('0812-3456-7890', style: Theme.of(context).textTheme.bodyMedium),
                ),
                Divider(height: 0),
                ListTile(
                  leading: Icon(Icons.badge, color: Theme.of(context).colorScheme.onSurface),
                  title: Text('Role', style: Theme.of(context).textTheme.bodyLarge),
                  subtitle: Text('Administrator', style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: GradientButton( // Use GradientButton
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout berhasil')),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0), // Adjust padding if needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout),
                    const SizedBox(width: 8),
                    Text('Logout', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
