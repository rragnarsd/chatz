import 'package:chatz/constants/colors.dart';
import 'package:flutter/material.dart';

class UIStyles {
  //Signin - Signup
  static const BoxDecoration authBottomBar = BoxDecoration(
    color: ConstColors.greenCyan,
    border: Border.fromBorderSide(
      BorderSide(color: ConstColors.black),
    ),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(27),
      topRight: Radius.circular(27),
    ),
  );

  static const OutlineInputBorder borders = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(13),
    ),
  );

  //Profile
  static BoxDecoration profileDecoration = BoxDecoration(
    border: Border.all(width: 1.5),
    borderRadius: BorderRadius.circular(13),
    boxShadow: [
      boxShadowPositive,
      boxShadowNegative,
    ],
  );

  static BoxDecoration profileDecorationAvatar = BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
    boxShadow: [
      boxShadowPositive,
      boxShadowNegative,
    ],
  );

  static BoxDecoration bottomSheet = const BoxDecoration(
    color: ConstColors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(27),
      topRight: Radius.circular(27),
    ),
  );

  static BoxShadow boxShadowPositive = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    blurRadius: 5,
    offset: const Offset(4, 4),
  );

  static BoxShadow boxShadowNegative = const BoxShadow(
    color: Colors.white,
    blurRadius: 8,
    offset: Offset(-4, -4),
  );

  //Auth
  static BoxDecoration iconDecoration = BoxDecoration(
    border: Border.all(width: 1.5),
    shape: BoxShape.circle,
    color: ConstColors.white,
  );

  //Chat
  static BoxDecoration chatDecoration = BoxDecoration(
    border: Border.all(
      color: ConstColors.black,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(13),
    ),
    color: ConstColors.redOrange,
  );

  //Landing Carousel
  static BoxDecoration carouselDecoration = BoxDecoration(
    border: Border.all(),
    borderRadius: BorderRadius.circular(45),
    color: Colors.white,
  );
}
