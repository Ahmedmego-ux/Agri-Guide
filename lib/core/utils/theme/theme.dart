import 'package:agri_guide_app/core/constans/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Shared constants ────────────────────────────────────────────────────────
const _kRadius = 12.0;
const _kBorderRadius = BorderRadius.all(Radius.circular(_kRadius));
const _kShape = RoundedRectangleBorder(borderRadius: _kBorderRadius);

// ── Light Theme ─────────────────────────────────────────────────────────────
ThemeData get lightTheme {
  final cs = ColorScheme.fromSeed(
    seedColor: primaryGreen,
    brightness: Brightness.light,
  );

  return ThemeData(
    brightness: Brightness.light,
    colorScheme: cs,
    useMaterial3: true,

    // ── Scaffold ──────────────────────────────────────────────────────────
    scaffoldBackgroundColor: cs.surface,

    // ── AppBar ────────────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      elevation: 0,
      scrolledUnderElevation: 2,
      shadowColor: cs.shadow,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: cs.surface,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: cs.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
    ),

    // ── Cards ─────────────────────────────────────────────────────────────
    cardColor: cs.surfaceContainerLow,
    cardTheme: CardThemeData(
      color: cs.surfaceContainerLow,
      elevation: 1,
      shadowColor: cs.shadow.withOpacity(0.4),
      shape: _kShape,
      clipBehavior: Clip.antiAlias,
    ),

    // ── Dialogs ───────────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: cs.surfaceContainerHigh,
      elevation: 6,
      shape: _kShape,
      titleTextStyle: TextStyle(
        color: cs.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ── Icons ─────────────────────────────────────────────────────────────
    iconTheme: IconThemeData(color: cs.onSurfaceVariant, size: 24),

    // ── Typography ────────────────────────────────────────────────────────
    textTheme: Typography.material2021(platform: TargetPlatform.android)
        .black
        .apply(
          bodyColor: cs.onSurface,
          displayColor: cs.onSurface,
        ),

    // ── Buttons ───────────────────────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 1,
        minimumSize: const Size(double.infinity, 52),
        shape: _kShape,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.primary,
        minimumSize: const Size(double.infinity, 52),
        shape: _kShape,
        side: BorderSide(color: cs.primary, width: 1.5),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: cs.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    ),

    // ── Input / TextField ─────────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cs.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.error, width: 2),
      ),
      labelStyle: TextStyle(color: cs.onSurfaceVariant),
      hintStyle: TextStyle(color: cs.onSurfaceVariant.withOpacity(0.6)),
      errorStyle: TextStyle(color: cs.error, fontSize: 12),
    ),

    // ── SnackBar ──────────────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: cs.inverseSurface,
      contentTextStyle: TextStyle(color: cs.onInverseSurface),
      actionTextColor: cs.inversePrimary,
      shape: _kShape,
      behavior: SnackBarBehavior.floating,
    ),

    // ── FAB ───────────────────────────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: cs.primaryContainer,
      foregroundColor: cs.onPrimaryContainer,
      elevation: 3,
      shape: _kShape,
    ),

    // ── Bottom Nav ────────────────────────────────────────────────────────
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: cs.surface,
      selectedItemColor: cs.primary,
      unselectedItemColor: cs.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // ── Divider ───────────────────────────────────────────────────────────
    dividerTheme: DividerThemeData(
      color: cs.outlineVariant,
      thickness: 1,
    ),
  );
}

// ── Dark Theme ──────────────────────────────────────────────────────────────
ThemeData get darkTheme {
  final cs = ColorScheme.fromSeed(
    seedColor: primaryGreen,
    brightness: Brightness.dark,
  );

  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: cs,
    useMaterial3: true,

    // ── Scaffold ──────────────────────────────────────────────────────────
    scaffoldBackgroundColor: cs.surface,

    // ── AppBar ────────────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: cs.surface,
      foregroundColor: cs.onSurface,
      elevation: 0,
      scrolledUnderElevation: 2,
      shadowColor: Colors.black54,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: cs.surface,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        color: cs.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
    ),

    // ── Cards ─────────────────────────────────────────────────────────────
    cardColor: cs.surfaceContainerLow,
    cardTheme: CardThemeData(
      color: cs.surfaceContainerLow,
      elevation: 1,
      shadowColor: Colors.black54,
      shape: _kShape,
      clipBehavior: Clip.antiAlias,
    ),

    // ── Dialogs ───────────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: cs.surfaceContainerHigh,
      elevation: 6,
      shape: _kShape,
      titleTextStyle: TextStyle(
        color: cs.onSurface,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // ── Icons ─────────────────────────────────────────────────────────────
    iconTheme: IconThemeData(color: cs.onSurfaceVariant, size: 24),

    // ── Typography ────────────────────────────────────────────────────────
    textTheme: Typography.material2021(platform: TargetPlatform.android)
        .white
        .apply(
          bodyColor: cs.onSurface,
          displayColor: cs.onSurface,
        ),

    // ── Buttons ───────────────────────────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 1,
        minimumSize: const Size(double.infinity, 52),
        shape: _kShape,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.primary,
        minimumSize: const Size(double.infinity, 52),
        shape: _kShape,
        side: BorderSide(color: cs.primary, width: 1.5),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: cs.primary,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    ),

    // ── Input / TextField ─────────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cs.surfaceContainerHighest,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: _kBorderRadius,
        borderSide: BorderSide(color: cs.error, width: 2),
      ),
      labelStyle: TextStyle(color: cs.onSurfaceVariant),
      hintStyle: TextStyle(color: cs.onSurfaceVariant),
      errorStyle: TextStyle(color: cs.error, fontSize: 12),
    ),

    // ── SnackBar ──────────────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: cs.inverseSurface,
      contentTextStyle: TextStyle(color: cs.onInverseSurface),
      actionTextColor: cs.inversePrimary,
      shape: _kShape,
      behavior: SnackBarBehavior.floating,
    ),

    // ── FAB ───────────────────────────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: cs.primaryContainer,
      foregroundColor: cs.onPrimaryContainer,
      elevation: 3,
      shape: _kShape,
    ),

    // ── Bottom Nav ────────────────────────────────────────────────────────
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: cs.surface,
      selectedItemColor: cs.primary,
      unselectedItemColor: cs.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // ── Divider ───────────────────────────────────────────────────────────
    dividerTheme: DividerThemeData(
      color: cs.outlineVariant,
      thickness: 1,
    ),
  );
}