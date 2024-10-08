import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/colors_theme.dart';
import 'styles_theme.dart';

final themeProvider = Provider<ThemeProvider>((_) => ThemeProvider());

class ThemeProvider {
  final ThemeData theme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: onPrimary,
    appBarTheme: appBarTheme,
    inputDecorationTheme: inputDecorationTheme,
    textTheme: textTheme,
    iconTheme: iconThemeData,
    elevatedButtonTheme: elevatedButtonThemeData,
    snackBarTheme: snackBarThemeData,
    dialogTheme: dialogThemeData,
    bottomSheetTheme: bottomSheetThemeData,
    dividerTheme: dividerThemeData,
    bottomNavigationBarTheme: bottomNavigationBarThemeData,
    cardTheme: cardThemeData,
  );
}
