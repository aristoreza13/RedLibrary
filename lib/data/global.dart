//class untuk membuat color sendiri dengan HexColor
import 'dart:convert';

import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF" + hex.toUpperCase().replaceAll("#", "");
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}

Color color1 = HexColor('#E02401');
Color color2 = HexColor('#F78812');
Color color3 = HexColor('#AB6D23');
Color color4 = HexColor('#51050F');

// color for home and details screens
const kBlackColor = Color(0xFF393939);
const kLightBlackColor = Color(0xFF8F8F8F);
const kIconColor = Color(0xFFF48A37);
const kProgressIndicator = Color(0xFFBE7066);
final kShadowColor = const Color(0xff0303030).withOpacity(.84);

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

String collaborativeJson = json.encode('flaskApiV2/collaborative.json');
