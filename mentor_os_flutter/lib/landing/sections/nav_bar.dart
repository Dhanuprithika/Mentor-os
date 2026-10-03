import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../widgets/glow_button.dart';

/// Top navigation bar for the MentorOS landing page.
///
/// Accepts a list of [sectionKeys] for smooth-scroll navigation.
/// Switches between desktop (full horizontal) and mobile (hamburger) layouts.
class LandingNavBar extends StatefulWidget {
  const LandingNavBar({
    super.key,
    required this.sectionKeys,
    required this.sectionLabels,
  });

  final List<GlobalKey> sectionKeys;
  final List<String> sectionLabels;

  @override
  State<LandingNavBar> createState() => _LandingNavBarState();
}

class _LandingNavBarState extends State<LandingNavBar>
    with SingleTickerProviderStateMixin {
  bool _mobileMenuOpen = false;
  late final AnimationController _menuController;
  late final Animation<double> _menuAnimation;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() => _mobileMenuOpen = !_mobileMenuOpen);
    if (_mobileMenuOpen) {
      _menuController.forward();
    } else {
      _menuController.reverse();
    }
  }

  void _scrollToSection(int index) {
    if (index >= widget.sectionKeys.length) return;
    final key = widget.sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
    if (_mobileMenuOpen) _toggleMenu();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < CosmicBreakpoints.mobile;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 64,
          decoration: BoxDecoration(
            color: CosmicColors.midnightNavy.withValues(alpha: 0.92),
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFF1E293B),
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile
                  ? CosmicSpacing.sectionPaddingHMobile
                  : CosmicSpacing.sectionPaddingHTablet,
            ),
            child: Row(
              children: [
                // Logo
                Text(
                  'MentorOS',
                  style: CosmicTextStyles.subheading().copyWith(
                    color: CosmicColors.starWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                if (!isMobile) ...[
                  // Desktop nav links
                  ...List.generate(widget.sectionLabels.length, (i) {
                    return _NavLink(
                      label: widget.sectionLabels[i],
                      onTap: () => _scrollToSection(i),
                    );
                  }),
                  const SizedBox(width: 24),
                  GlowButton(
                    label: 'Get Started',
                    onPressed: () => _scrollToSection(0),
                    minWidth: 120,
                  ),
                ] else ...[
                  // Mobile hamburger
                  IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: _menuAnimation,
                      color: CosmicColors.starWhite,
                    ),
                    onPressed: _toggleMenu,
                  ),
                ],
              ],
            ),
          ),
        ),
        // Mobile dropdown menu
        if (isMobile)
          SizeTransition(
            sizeFactor: _menuAnimation,
            child: Container(
              color: CosmicColors.midnightNavy.withValues(alpha: 0.97),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  ...List.generate(widget.sectionLabels.length, (i) {
                    return InkWell(
                      onTap: () => _scrollToSection(i),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        child: Text(
                          widget.sectionLabels[i],
                          style: CosmicTextStyles.navLabel().copyWith(
                            color: CosmicColors.mutedText,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GlowButton(
                      label: 'Get Started',
                      onPressed: () => _scrollToSection(0),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: CosmicTextStyles.navLabel().copyWith(
                  color: _hovered
                      ? CosmicColors.starWhite
                      : CosmicColors.mutedText,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 1.5,
                width: _hovered ? 40 : 0,
                decoration: BoxDecoration(
                  color: CosmicColors.cyberCyan,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
