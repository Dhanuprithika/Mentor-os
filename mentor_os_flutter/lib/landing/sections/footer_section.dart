import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Footer widget with logo, tagline, link columns, and copyright.
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < CosmicBreakpoints.mobile;

    final hPad = isMobile
        ? CosmicSpacing.sectionPaddingHMobile
        : CosmicSpacing.sectionPaddingHDesktop;

    return Container(
      color: CosmicColors.deepSpace,
      padding: EdgeInsets.fromLTRB(hPad, 64, hPad, 40),
      child: Column(
        children: [
          Container(
            height: 1,
            color: CosmicColors.cardBorder,
            margin: const EdgeInsets.only(bottom: 48),
          ),
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          const SizedBox(height: 48),
          Container(
            height: 1,
            color: CosmicColors.cardBorder,
            margin: const EdgeInsets.only(bottom: 24),
          ),
          Text(
            '© 2026 MentorOS. Built for the future of mentorship.',
            textAlign: TextAlign.center,
            style: CosmicTextStyles.bodySmall().copyWith(
              fontSize: 13,
              color: CosmicColors.dimText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildBrand(),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: _buildLinkColumn(
            'Product',
            ['Features', 'How It Works', 'About'],
          ),
        ),
        Expanded(
          child: _buildLinkColumn(
            'Connect',
            ['GitHub', 'Contact'],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrand(),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildLinkColumn(
                'Product',
                ['Features', 'How It Works', 'About'],
              ),
            ),
            Expanded(
              child: _buildLinkColumn(
                'Connect',
                ['GitHub', 'Contact'],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MentorOS',
          style: CosmicTextStyles.subheading().copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: CosmicColors.starWhite,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Text(
            'AI-powered mentorship for structured growth.',
            style: CosmicTextStyles.bodySmall().copyWith(
              color: CosmicColors.mutedText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLinkColumn(String heading, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: CosmicTextStyles.navLabel().copyWith(
            color: CosmicColors.starWhite,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: null, // TODO: implement routing
                child: Text(
                  link,
                  style: CosmicTextStyles.bodySmall().copyWith(
                    color: CosmicColors.dimText,
                    fontSize: 13,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
