library my.globals;

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

/// Constatns for text and fonts
const double textSizeDefault = 16;
const double headTextSizeDefault = 24;
const double titleTextSizeDefault = 36;

bool isLoggedin = false;

/// Alterable font sizes
double textSize = 16;
double headTextSize = 24;
double titleTextSize = 36;

TextStyle defaultFontTitle = GoogleFonts.lato(
  fontSize: titleTextSize,
  fontWeight: FontWeight.w600,
);

TextStyle defaultFontHeader = GoogleFonts.lato(
  fontSize: headTextSize,
  fontWeight: FontWeight.w600,
);

TextStyle defaultFontText = GoogleFonts.lato(
  fontSize: textSize,
  fontWeight: FontWeight.w400,
);
