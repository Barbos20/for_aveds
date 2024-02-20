import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textTheme = TextTheme(
  displayMedium: GoogleFonts.outfit(
    textStyle: const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
  ),
  displaySmall: GoogleFonts.outfit(
    textStyle: const TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(91, 91, 91, 1),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
  ),
  titleMedium: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 17,
      color: Color.fromRGBO(242, 121, 107, 1),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
  ),
  bodyMedium: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 1.1,
    ),
  ),
  labelMedium: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w300,
      height: 1.1,
    ),
  ),
  labelSmall: GoogleFonts.outfit(
    textStyle: const TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(117, 113, 113, 1),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      height: 1.1,
    ),
  ),
);
