part of '../home_screen.dart';

class FloatingActionButtonAdd extends StatelessWidget {
  const FloatingActionButtonAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Colors.grey.shade600,
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 5),
        ),
      ]),
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
