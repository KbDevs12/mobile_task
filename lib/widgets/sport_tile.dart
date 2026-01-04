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
    return const Placeholder();
  }
}
