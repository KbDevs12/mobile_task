import 'package:flutter/material.dart';
import '../models/cabang_olahraga.dart';

class CabangOlahragaListTile extends StatelessWidget {
  final CabangOlahraga cabangOlahraga;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CabangOlahragaListTile({
    Key? key,
    required this.cabangOlahraga,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: colorScheme.primary.withOpacity(0.1),
        highlightColor: colorScheme.primary.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cabangOlahraga.namaCabang,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Chip(
                      label: Text(cabangOlahraga.kategori),
                      avatar: Icon(Icons.category, color: colorScheme.onSecondary),
                      backgroundColor: colorScheme.secondary.withOpacity(0.8),
                      labelStyle: textTheme.labelLarge?.copyWith(color: colorScheme.onSecondary),
                    ),
                    const SizedBox(height: 12),

                    _buildDetailRow(context, Icons.bar_chart, cabangOlahraga.tingkat),
                    const SizedBox(height: 6),
                    _buildDetailRow(context, Icons.group, '${cabangOlahraga.jumlahAtlet} atlet'),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
                onPressed: onDelete,
                tooltip: 'Hapus Cabang Olahraga',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
