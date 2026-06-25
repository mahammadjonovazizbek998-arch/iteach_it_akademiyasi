import 'package:flutter/material.dart';

class ThemeClass extends ThemeExtension<ThemeClass> {
  final Color logoBegin,
      logoBegin2,
      logoBegin3,
      text,
      textIT,
      loginBackgroun,
      unselectedText,
      selectedItemColor,
      unselectedItemColor,
      containerBuilder,
      dataColor;

  ThemeClass({
    required this.logoBegin,
    required this.logoBegin2,
    required this.logoBegin3,
    required this.text,
    required this.textIT,
    required this.loginBackgroun,
    required this.unselectedText,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.containerBuilder,
    required this.dataColor,
  });

  @override
  ThemeExtension<ThemeClass> copyWith() {
    return ThemeClass(
      logoBegin: logoBegin,
      logoBegin2: logoBegin2,
      logoBegin3: logoBegin3,
      text: text,
      textIT: textIT,
      loginBackgroun: loginBackgroun,
      unselectedText: unselectedText,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      containerBuilder: containerBuilder,
      dataColor: dataColor,
    );
  }

  @override
  ThemeExtension<ThemeClass> lerp(
    covariant ThemeExtension<ThemeClass>? other,
    double t,
  ) {
    if (other is! ThemeClass) return this;
    return ThemeClass(
      logoBegin: Color.lerp(logoBegin, logoBegin, t)!,
      logoBegin2: Color.lerp(logoBegin2, logoBegin2, t)!,
      logoBegin3: Color.lerp(logoBegin3, logoBegin3, t)!,
      text: Color.lerp(text, text, t)!,
      textIT: Color.lerp(textIT, textIT, t)!,
      loginBackgroun: Color.lerp(loginBackgroun, loginBackgroun, t)!,
      unselectedText: Color.lerp(unselectedText, unselectedText, t)!,
      selectedItemColor: Color.lerp(selectedItemColor, selectedItemColor, t)!,
      unselectedItemColor: Color.lerp(
        unselectedItemColor,
        unselectedItemColor,
        t,
      )!,
      containerBuilder: Color.lerp(containerBuilder, containerBuilder, t)!,
      dataColor: Color.lerp(dataColor, dataColor, t)!,
    );
  }
}

final ThemeClass lightCustom = ThemeClass(
  logoBegin: Colors.black87,
  logoBegin2: Colors.green.shade900,
  logoBegin3: Colors.green.shade700,
  text: Colors.black,
  textIT: Colors.green.shade400,
  loginBackgroun: Colors.white,
  unselectedText: Colors.black54,
  selectedItemColor: Color(0xFF506FF7),
  unselectedItemColor: Color(0xE5413F47),
  containerBuilder: Color(0xFF5047E5),
  dataColor: Color(0xFF2F3282),
);
final ThemeClass darkCustom = ThemeClass(
  logoBegin: Color(0xFF121212),
  logoBegin2: Colors.green.shade900,
  logoBegin3: Colors.green.shade700,
  text: Colors.white,
  textIT: Colors.green.shade500,
  loginBackgroun: Colors.black26,
  unselectedText: Colors.white54,
  selectedItemColor: Color(0xFF6C8BF9),
  unselectedItemColor: Color(0xFF5D6587),
  containerBuilder: Color(0xFF1D224A),
  dataColor: Color(0xFF5047E5),
);
