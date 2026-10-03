import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Cosmic design system for MentorOS.
class CosmicColors {
  CosmicColors._();

  static const Color deepSpace = Color(0xFF080B14);
  static const Color midnightNavy = Color(0xFF0D1117);
  static const Color cardSurface = Color(0xFF111827);
  static const Color cardSurfaceAlt = Color(0xFF0F172A);
  static const Color cardBorder = Color(0xFF1E293B);
  static const Color cosmicViolet = Color(0xFF7C3AED);
  static const Color deepIndigo = Color(0xFF4F46E5);
  static const Color cyberCyan = Color(0xFF06B6D4);
  static const Color softLavender = Color(0xFFA78BFA);
  static const Color softPurple = Color(0xFF8B5CF6);
  static const Color starWhite = Color(0xFFF8FAFC);
  static const Color mutedText = Color(0xFF94A3B8);
  static const Color dimText = Color(0xFF475569);
  static const Color accentText = Color(0xFFA78BFA);
}

/// Breakpoints for responsive layouts.
class CosmicBreakpoints {
  CosmicBreakpoints._();

  static const double mobile = 768.0;
  static const double tablet = 1200.0;
}

/// Spacing constants.
class CosmicSpacing {
  CosmicSpacing._();

  static const double sectionPaddingHDesktop = 80.0;
  static const double sectionPaddingHTablet = 48.0;
  static const double sectionPaddingHMobile = 20.0;
  static const double sectionPaddingV = 96.0;
  static const double sectionPaddingVMobile = 64.0;
}

/// Text style helpers.
class CosmicTextStyles {
  CosmicTextStyles._();

  static TextStyle heroHeading(double screenWidth) {
    double size;
    if (screenWidth > CosmicBreakpoints.tablet) {
      size = 72.0;
    } else if (screenWidth > CosmicBreakpoints.mobile) {
      size = 56.0;
    } else {
      size = 40.0;
    }
    return GoogleFonts.spaceGrotesk(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: CosmicColors.starWhite,
      height: 1.1,
      letterSpacing: -1.0,
    );
  }

  static TextStyle sectionHeading(double screenWidth) {
    double size;
    if (screenWidth > CosmicBreakpoints.tablet) {
      size = 48.0;
    } else if (screenWidth > CosmicBreakpoints.mobile) {
      size = 40.0;
    } else {
      size = 30.0;
    }
    return GoogleFonts.spaceGrotesk(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: CosmicColors.starWhite,
      height: 1.15,
      letterSpacing: -0.5,
    );
  }

  static TextStyle subheading() => GoogleFonts.spaceGrotesk(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: CosmicColors.starWhite,
        height: 1.3,
      );

  static TextStyle body() => GoogleFonts.inter(
        fontSize: 17.0,
        fontWeight: FontWeight.w400,
        color: CosmicColors.mutedText,
        height: 1.7,
      );

  static TextStyle bodySmall() => GoogleFonts.inter(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: CosmicColors.mutedText,
        height: 1.6,
      );

  static TextStyle navLabel() => GoogleFonts.inter(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: CosmicColors.mutedText,
      );

  static TextStyle label() => GoogleFonts.inter(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: CosmicColors.cyberCyan,
        letterSpacing: 2.0,
      );

  static TextStyle stepNumber() => GoogleFonts.spaceGrotesk(
        fontSize: 64.0,
        fontWeight: FontWeight.w700,
        color: CosmicColors.cyberCyan,
        height: 1.0,
      );

  static TextStyle buttonLabel() => GoogleFonts.inter(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      );
}

/// Material theme builder.
class CosmicTheme {
  CosmicTheme._();

  static ThemeData buildMaterialTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CosmicColors.deepSpace,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CosmicColors.cosmicViolet,
        brightness: Brightness.dark,
      ).copyWith(
        primary: CosmicColors.cosmicViolet,
        secondary: CosmicColors.cyberCyan,
        surface: CosmicColors.cardSurface,
      ),
      useMaterial3: true,
    );
  }
}
