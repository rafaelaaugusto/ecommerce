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

const appBarTheme = AppBarTheme(
  centerTitle: true,
  iconTheme: IconThemeData(
    color: secondary,
  ),
);
