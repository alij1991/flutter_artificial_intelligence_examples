import 'package:flutter/material.dart';
import 'package:flutter_artificial_intelligence_examples/utils/constants.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: const Color(0xffFCF8F3),
  cardColor: const Color(0xffAEDADD),
  backgroundColor: const Color(0xffFCF8F3),
  primaryColorDark: const Color(0xff6E7DA2),
  primaryColorLight: const Color(0xffDB996C),
  colorScheme: const ColorScheme.dark().copyWith(
    secondary: Color(0xff1E2022),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: const Color(0xff001F3F),
  cardColor: const Color(0xff0D63A5),
  backgroundColor: const Color(0xff001F3F),
  primaryColorDark: const Color(0xff083358),
  primaryColorLight: const Color(0xffFFD717),
  colorScheme: const ColorScheme.dark().copyWith(
    secondary: const Color(0xffE8F9FD),
  ),
);