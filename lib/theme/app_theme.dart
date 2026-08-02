import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Trainings-Tool Look: klares Teal/Slate-Schema, DM Sans + JetBrains Mono.
class AppTheme {
  static const Color _seed = Color(0xFF0F766E);

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
      surface: brightness == Brightness.light
          ? const Color(0xFFF4F7F6)
          : const Color(0xFF121816),
    );

    final baseText = GoogleFonts.dmSansTextTheme(
      ThemeData(brightness: brightness).textTheme,
    );
    final mono = GoogleFonts.jetBrainsMono();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: baseText,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      chipTheme: ChipThemeData(
        selectedColor: colorScheme.primaryContainer,
        labelStyle: baseText.labelLarge,
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      sliderTheme: SliderThemeData(
        showValueIndicator: ShowValueIndicator.onDrag,
        valueIndicatorTextStyle: mono.copyWith(fontSize: 12),
      ),
      extensions: [CodeNameStyle(textStyle: mono.copyWith(fontSize: 12))],
    );
  }
}

@immutable
class CodeNameStyle extends ThemeExtension<CodeNameStyle> {
  const CodeNameStyle({required this.textStyle});

  final TextStyle textStyle;

  @override
  CodeNameStyle copyWith({TextStyle? textStyle}) =>
      CodeNameStyle(textStyle: textStyle ?? this.textStyle);

  @override
  CodeNameStyle lerp(ThemeExtension<CodeNameStyle>? other, double t) {
    if (other is! CodeNameStyle) return this;
    return CodeNameStyle(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
    );
  }
}
