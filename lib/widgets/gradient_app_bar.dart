import 'package:flutter/material.dart';
import 'package:tugas_mobile/main.dart'; // For color constants
import 'package:google_fonts/google_fonts.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Color>? gradientColors;
  final Widget? leading;
  final List<Widget>? actions;

  const GradientAppBar({
    super.key,
    required this.title,
    this.gradientColors,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final defaultGradientColors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors ?? defaultGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AppBar(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, // White text on primary background
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: leading,
        actions: actions,
        backgroundColor: Colors.transparent, // Make AppBar background transparent
        elevation: 0, // No shadow from AppBar itself
        foregroundColor: Theme.of(context).colorScheme.onPrimary, // Icon color
        centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
