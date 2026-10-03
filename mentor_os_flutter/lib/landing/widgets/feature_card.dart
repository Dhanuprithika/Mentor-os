import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A reusable feature card with icon, title, and description.
/// Shows a hover lift effect on desktop.
class FeatureCard extends StatefulWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.accentColor = CosmicColors.cyberCyan,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: CosmicColors.cardSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? CosmicColors.softLavender.withValues(alpha: 0.5)
                : CosmicColors.cardBorder,
            width: 1.0,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: CosmicColors.cosmicViolet.withValues(alpha: 0.15),
                    blurRadius: 24,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.icon,
                color: widget.accentColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: CosmicTextStyles.subheading().copyWith(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              widget.description,
              style: CosmicTextStyles.bodySmall(),
            ),
          ],
        ),
      ),
    );
  }
}
