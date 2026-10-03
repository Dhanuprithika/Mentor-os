import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// A reusable glowing CTA button with hover effects.
///
/// [isPrimary] controls filled (violet gradient) vs outlined (cyan border).
class GlowButton extends StatefulWidget {
  const GlowButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.minWidth = 180.0,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double minWidth;

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: BoxConstraints(minWidth: widget.minWidth),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: widget.isPrimary
              ? BoxDecoration(
                  gradient: LinearGradient(
                    colors: _hovered
                        ? [
                            CosmicColors.softPurple,
                            CosmicColors.deepIndigo,
                          ]
                        : [
                            CosmicColors.cosmicViolet,
                            CosmicColors.deepIndigo,
                          ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: CosmicColors.cosmicViolet
                          .withValues(alpha: _hovered ? 0.55 : 0.30),
                      blurRadius: _hovered ? 28 : 16,
                      spreadRadius: _hovered ? 2 : 0,
                    ),
                  ],
                )
              : BoxDecoration(
                  color: _hovered
                      ? CosmicColors.cyberCyan.withValues(alpha: 0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CosmicColors.cyberCyan
                        .withValues(alpha: _hovered ? 1.0 : 0.7),
                    width: 1.5,
                  ),
                ),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: CosmicTextStyles.buttonLabel().copyWith(
              color: widget.isPrimary
                  ? CosmicColors.starWhite
                  : CosmicColors.cyberCyan,
            ),
          ),
        ),
      ),
    );
  }
}
