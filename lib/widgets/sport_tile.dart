import 'package:flutter/material.dart';

class SportTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const SportTile({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(name),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
