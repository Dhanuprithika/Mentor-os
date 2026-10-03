import 'package:flutter/material.dart';

import '../landing/sections/ai_section.dart';
import '../landing/sections/cta_section.dart';
import '../landing/sections/features_section.dart';
import '../landing/sections/footer_section.dart';
import '../landing/sections/hero_section.dart';
import '../landing/sections/how_it_works_section.dart';
import '../landing/sections/journey_section.dart';
import '../landing/sections/nav_bar.dart';
import '../landing/sections/problem_section.dart';
import '../theme/app_theme.dart';

/// Root landing page widget.
///
/// Owns the [ScrollController] and section [GlobalKey]s used for
/// smooth-scroll navigation from the [LandingNavBar].
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _journeyKey = GlobalKey();
  final GlobalKey _aiKey = GlobalKey();

  void _scrollToHowItWorks() {
    final ctx = _howItWorksKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicColors.deepSpace,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: _heroKey,
                  onSeHowItWorks: _scrollToHowItWorks,
                ),
                JourneySection(key: _journeyKey),
                ProblemSection(),
                HowItWorksSection(key: _howItWorksKey),
                FeaturesSection(key: _featuresKey),
                AiSection(key: _aiKey),
                const CtaSection(),
                const FooterSection(),
              ],
            ),
          ),

          // NavBar floats above scroll content
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LandingNavBar(
              sectionKeys: [
                _heroKey,
                _howItWorksKey,
                _featuresKey,
                _aiKey,
              ],
              sectionLabels: const [
                'Home',
                'How It Works',
                'Features',
                'About',
              ],
            ),
          ),
        ],
      ),
    );
  }
}
