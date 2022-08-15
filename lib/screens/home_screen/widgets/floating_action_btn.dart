part of '../home_screen.dart';

class FloatingActionButtonAdd extends StatelessWidget {
  const FloatingActionButtonAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: UIStyles.profileDecorationAvatar,
      child: CircleIconBtn(
          btnColor: ConstColors.redOrange,
          iconColor: ConstColors.black,
          height: 56,
          icon: const FaIcon(
            FontAwesomeIcons.plus,
            color: ConstColors.black,
          ),
          onTapped: () {
            Navigator.pushNamed(
              context,
              AppRouter.searchScreen,
            );
          }),
    );
  }
}
