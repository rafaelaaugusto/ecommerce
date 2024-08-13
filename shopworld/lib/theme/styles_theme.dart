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
    color: primary,
    fontSize: Insets.xxl,
  ),
  labelSmall: GoogleFonts.lato(
    color: onSecondary,
    fontSize: Insets.xl,
  ),
  titleSmall: GoogleFonts.lato(
    color: primary,
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
  floatingLabelStyle: TextStyle(color: onSurface),
  border: borderStyle,
  focusedBorder: borderStyle,
  enabledBorder: borderStyle,
  contentPadding: EdgeInsets.all(Insets.l),
);

final appBarTheme = AppBarTheme(
  titleTextStyle: GoogleFonts.lato(
    color: primary,
    fontSize: Insets.xxl,
  ),
  elevation: 0,
  scrolledUnderElevation: 0,
  actionsIconTheme: iconThemeData,
  centerTitle: true,
  iconTheme: const IconThemeData(
    color: primary,
  ),
);

const iconThemeData = IconThemeData(color: secondary);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: secondary,
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
    foregroundColor: secondary,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: secondary),
      borderRadius: BorderRadius.circular(Insets.m),
    ),
    padding: const EdgeInsets.all(14),
    textStyle: GoogleFonts.lato(
      fontSize: Insets.xxl,
    ),
  ),
);

const snackBarThemeData = SnackBarThemeData(backgroundColor: primary);

const dialogThemeData = DialogTheme(elevation: 0);

const bottomSheetThemeData = BottomSheetThemeData(
  elevation: 0,
  backgroundColor: onPrimary,
);

const dividerThemeData = DividerThemeData(color: primaryContainer);

const bottomNavigationBarThemeData = BottomNavigationBarThemeData(
  selectedIconTheme: iconThemeData,
  selectedLabelStyle: TextStyle(
    color: secondary,
  ),
);

final cardThemeData = CardTheme(
  elevation: 0,
  margin: EdgeInsets.zero,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Insets.m),
    side: const BorderSide(
      color: primaryContainer,
    ),
  ),
);
