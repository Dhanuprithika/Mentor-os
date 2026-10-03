import 'package:flutter/material.dart';

import 'landing/landing_page.dart';
import 'theme/app_theme.dart';

/// Root application widget for MentorOS.
///
/// Uses the full cosmic dark theme. No light/dark toggle at this stage —
/// the product always presents the deep-space aesthetic.
class MentorOSApp extends StatelessWidget {
  const MentorOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorOS',
      debugShowCheckedModeBanner: false,
      theme: CosmicTheme.buildMaterialTheme(),
      home: const LandingPage(),
    );
  }
}
