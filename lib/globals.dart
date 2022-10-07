library my.globals;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Constants for text and fonts
const double textSizeDefault = 16;
const double headTextSizeDefault = 24;
const double titleTextSizeDefault = 36;

const Color colorLight = Color(0xffEEEEEE);
const Color colorDark = Color(0xff222831);
const Color colorHighlight = Color(0xff00ADB5);
const Color colorMid = Color(0xff393E46);

bool isLoggedin = false;

/// Alterable font sizes
double textSize = 16;
double headTextSize = 24;
double titleTextSize = 36;

// Styles for various text components
TextStyle defaultFontTitleBold = GoogleFonts.lato(
  fontSize: headTextSize,
  fontWeight: FontWeight.bold,
  color: colorLight,
);

TextStyle defaultFontTitle = GoogleFonts.lato(
  fontSize: titleTextSize,
  fontWeight: FontWeight.w600,
  color: colorLight,
);

TextStyle defaultFontHeader = GoogleFonts.lato(
  fontSize: headTextSize,
  fontWeight: FontWeight.w600,
);

TextStyle defaultFontText = GoogleFonts.lato(
  fontSize: textSize,
  fontWeight: FontWeight.w400,
);

TextStyle buttonFontText = GoogleFonts.lato(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

TextStyle defaultUserHeader = GoogleFonts.lato(
  fontSize: headTextSize,
  fontWeight: FontWeight.w600,
  color: colorLight,
);

TextStyle linkText = GoogleFonts.lato(
  fontSize: titleTextSize,
  fontWeight: FontWeight.w600,
  color: colorHighlight,
  decoration: TextDecoration.underline,
);

// Styles for various buttons
ButtonStyle profileButton = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
    backgroundColor: MaterialStateProperty.all(colorHighlight),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )));

ButtonStyle profileButtonSignOut = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    )));
  
