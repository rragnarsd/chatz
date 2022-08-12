import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class AppBarLoading extends StatelessWidget {
  const AppBarLoading({
    Key? key,
    required this.leading,
    required this.title,
  }) : super(key: key);

  final Widget? leading;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      leading: leading,
      iconTheme: const IconThemeData(
        color: ConstColors.black87,
      ),
      actions: const [
        ShimmerLoading.circular(width: 40, height: 40),
      ],
      title: title,
      titleTextStyle: TextStyles.style16Bold.copyWith(
        color: ConstColors.black87,
      ),
    );
  }
}
