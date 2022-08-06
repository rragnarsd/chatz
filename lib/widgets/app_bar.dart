import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    required this.leading,
    required this.actions,
    required this.title,
  }) : super(key: key);

  final Widget leading;
  final List<Widget> actions;
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
      actions: actions,
      title: title,
      titleTextStyle: TextStyles.style16Bold.copyWith(
        color: ConstColors.black87,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
