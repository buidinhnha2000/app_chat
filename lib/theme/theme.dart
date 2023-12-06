import 'package:flutter/material.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF000000),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFF363F3B),
        onPrimaryContainer: Color(0xFFFBE365),
        secondary: Color(0xFFF3F6F6),
        onSecondary: Color(0xFFE7E2D9),
        secondaryContainer: Color(0xFF21A090),
        onSecondaryContainer: Color(0xFF363F3B),
        tertiary: Color(0xFFA8D0B4),
        onTertiary: Color(0xFF133724),
        tertiaryContainer: Color(0xFF2B4E39),
        onTertiaryContainer: Color(0xFFC4ECCF),
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFF93000A),
        onError: Color(0xFF690005),
        onErrorContainer: Color(0xFFFFDAD6),
        background: Color(0xFFFFFFFF),
        onBackground: Color(0xFF000000),
        surface: Color(0xFF1D1B16),
        onSurface: Color(0xFFFAFAD2),
        surfaceVariant: Color(0xFFE7E2D9),
        onSurfaceVariant: Color(0xFFCDC6B4),
        outline: Color(0xFF969080),
        onInverseSurface: Color(0xFF22232b),
        inverseSurface: Color(0xFFE7E2D9),
        inversePrimary: Color(0xFFE7E2D9),
        shadow: Color(0xFF000000),
        surfaceTint: Color(0xFFDEC74C),
        outlineVariant: Color(0xFF4A4739),
        scrim: Color(0xFFFFFFFF),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFFFFFFF),
        onPrimary: Color(0xFF000000),
        primaryContainer: Color(0xFF363F3B),
        onPrimaryContainer: Color(0xFFFBE365),
        secondary: Color(0xFF22232b),
        onSecondary: Color(0xFFE7E2D9),
        secondaryContainer: Color(0xFF21A090),
        onSecondaryContainer: Color(0xFF949494),
        tertiary: Color(0xFFA8D0B4),
        onTertiary: Color(0xFF133724),
        tertiaryContainer: Color(0xFF2B4E39),
        onTertiaryContainer: Color(0xFFC4ECCF),
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFF93000A),
        onError: Color(0xFF690005),
        onErrorContainer: Color(0xFFFFDAD6),
        background: Color(0xFF000000),
        onBackground: Color(0xFFFFFFFF),
        surface: Color(0xFF1D1B16),
        onSurface: Color(0xFFFAFAD2),
        surfaceVariant: Color(0xFFE7E2D9),
        onSurfaceVariant: Color(0xFFCDC6B4),
        outline: Color(0xFF969080),
        onInverseSurface: Color(0xFF22232b),
        inverseSurface: Color(0xFFE7E2D9),
        inversePrimary: Color(0xFFE7E2D9),
        shadow: Color(0xFF000000),
        surfaceTint: Color(0xFFDEC74C),
        outlineVariant: Color(0xFF4A4739),
        scrim: Color(0xFFFFFFFF),
      ),
    );
  }
}
