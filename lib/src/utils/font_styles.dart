import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class MyFontStyles {
  static TextTheme textTheme = GoogleFonts.patrickHandTextTheme();

  static final title = GoogleFonts.pacifico(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static final button = GoogleFonts.luckiestGuy(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static final subtitleColor = GoogleFonts.patrickHand(
    color: primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final subSubtitle = GoogleFonts.patrickHand(
    color: Colors.grey.shade500,
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );

  static final normal = GoogleFonts.patrickHand(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}
