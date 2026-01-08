import 'package:flutter/material.dart';
import 'package:tugas_mobile/main.dart'; // For color constants

class GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const GradientButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.gradientColors,
    this.borderRadius,
    this.height,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final defaultGradientColors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
    ];

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors ?? defaultGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Make button transparent to show gradient
          shadowColor: Colors.transparent, // No shadow from ElevatedButton itself
          foregroundColor: Theme.of(context).colorScheme.onPrimary, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.medium), // Use theme text style
        ),
        child: child,
      ),
    );
  }
}
