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
          iconColor: Colors.black,
          height: 56,
          icon: const FaIcon(
            FontAwesomeIcons.plus,
            color: ConstColors.black,
          ),
          onTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          }),
    );
  }
}
