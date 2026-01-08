import 'package:flutter/material.dart';
import '../models/atlet.dart';

// Widget kustom untuk menampilkan detail satu atlet dalam daftar
class AtletListTile extends StatelessWidget {
  final Atlet atlet; // Objek atlet yang akan ditampilkan
  final VoidCallback onTap; // Callback ketika tile di-tap
  final VoidCallback onDelete; // Callback ketika atlet dihapus

  const AtletListTile({
    Key? key,
    required this.atlet,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      // Margin dan shape sudah diatur di CardTheme global
      clipBehavior: Clip.antiAlias, // Ensures the ripple effect stays within the card's rounded corners
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
                    // Nama Atlet
                    Text(
                      atlet.nama,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Chip untuk Cabang Olahraga
                    Chip(
                      label: Text(atlet.cabangAtlet),
                      avatar: Icon(Icons.sports_soccer, color: colorScheme.onSecondary),
                      backgroundColor: colorScheme.secondary.withOpacity(0.8),
                      labelStyle: textTheme.labelLarge?.copyWith(color: colorScheme.onSecondary),
                    ),
                    const SizedBox(height: 12),

                    // Detail Lainnya
                    _buildDetailRow(context, Icons.cake_outlined, '${atlet.umur} tahun'),
                    const SizedBox(height: 6),
                    _buildDetailRow(context, Icons.person_outline, atlet.jenisKelamin),
                    const SizedBox(height: 6),
                    _buildDetailRow(context, Icons.fitness_center_outlined, '${atlet.beratBadan} kg'),
                    const SizedBox(height: 6),
                    _buildDetailRow(context, Icons.height_outlined, '${atlet.tinggiBadan} cm'),
                  ],
                ),
              ),
              // Tombol Hapus
              IconButton(
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
                onPressed: onDelete,
                tooltip: 'Hapus Atlet',
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