import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_theme.dart';

Future<void> downloadGoogleFonts() async {
  try {
    await GoogleFonts.pendingFonts([
      GoogleFonts.merriweather(),
      GoogleFonts.lato(),
      GoogleFonts.merriweatherTextTheme(),
      GoogleFonts.latoTextTheme(),
    ]);
  } catch (_) {}
}

final latoTextTheme = GoogleFonts.latoTextTheme(
  ThemeData.light(useMaterial3: true).textTheme,
);

final textTheme = latoTextTheme.copyWith(
  titleLarge: GoogleFonts.merriweather(
    color: secondary,
    fontSize: Insets.xxl,
  ),
  labelSmall: GoogleFonts.lato(
    color: onSecondary,
    fontSize: Insets.xl,
  ),
  titleSmall: GoogleFonts.lato(
    color: secondary,
    fontWeight: FontWeight.bold,
  ),
);

const borderStyle = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryContainer,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(Insets.m),
  ),
);

const inputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(
    color: onSurface,
    fontWeight: FontWeight.normal,
  ),
  border: borderStyle,
  focusedBorder: borderStyle,
  enabledBorder: borderStyle,
  contentPadding: EdgeInsets.all(Insets.l),
);

final appBarTheme = AppBarTheme(
  titleTextStyle: GoogleFonts.lato(
    color: secondary,
    fontWeight: FontWeight.bold,
    fontSize: Insets.xxl,
  ),
  actionsIconTheme: iconThemeData,
  centerTitle: true,
  iconTheme: const IconThemeData(
    color: secondary,
  ),
);

const iconThemeData = IconThemeData(color: primary);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: primary,
    foregroundColor: onPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Insets.m),
    ),
    padding: const EdgeInsets.all(Insets.xxl),
    textStyle: GoogleFonts.lato(
      fontSize: Insets.xxl,
    ),
  ),
);

final elevatedButtonOutlinedThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: onPrimary,
    foregroundColor: primary,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: primary),
      borderRadius: BorderRadius.circular(Insets.m),
    ),
    padding: const EdgeInsets.all(14),
    textStyle: GoogleFonts.lato(
      fontSize: Insets.xxl,
    ),
  ),
);
