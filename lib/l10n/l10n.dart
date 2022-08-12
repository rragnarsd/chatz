import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('is'),
  ];

  static String language(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'is':
        return 'Íslenska';
      default:
        return 'en';
    }
  }
}
