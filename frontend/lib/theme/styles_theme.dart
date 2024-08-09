import 'package:fleasy/fleasy.dart';
import 'package:flutter/material.dart';

import 'colors_theme.dart';

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
