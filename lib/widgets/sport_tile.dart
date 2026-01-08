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
      // Card styling from main.dart CardTheme
      child: InkWell( // Use InkWell for ripple effect
        borderRadius: Theme.of(context).cardTheme.shape?.borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28), // Use theme color for icon
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium, // Use theme typography
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            ],
          ),
        ),
      ),
    );
  }
}
