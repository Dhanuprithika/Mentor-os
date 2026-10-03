import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Reusable section heading with an optional small label tag and subtitle.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.label,
    this.subtitle,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textAlign = TextAlign.center,
  });

  final String title;
  final String? label;
  final String? subtitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (label != null) ...[
          Text(
            label!.toUpperCase(),
            textAlign: textAlign,
            style: CosmicTextStyles.label(),
          ),
          const SizedBox(height: 16),
        ],
        Text(
          title,
          textAlign: textAlign,
          style: CosmicTextStyles.sectionHeading(screenWidth),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 20),
          Text(
            subtitle!,
            textAlign: textAlign,
            style: CosmicTextStyles.body(),
          ),
        ],
      ],
    );
  }
}
