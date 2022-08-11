part of '../profile_screen.dart';

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow({
    Key? key,
    required this.userData,
    required this.userKey,
    required this.userValue,
    this.function,
    this.isChangeable = false,
  }) : super(key: key);

  final dynamic userData;
  final String userKey;
  final String userValue;
  final bool isChangeable;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          userKey,
          style: TextStyles.style14.copyWith(
            color: Colors.grey.shade500,
          ),
        ),
        Row(
          children: [
            Text(
              userValue,
              style: TextStyles.style14Bold.copyWith(
                color: ConstColors.black87,
              ),
            ),
            isChangeable == false
                ? const SizedBox.shrink()
                : IconButton(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.zero,
                    onPressed: function,
                    icon: const FaIcon(
                      FontAwesomeIcons.penToSquare,
                      color: ConstColors.darkerCyan,
                    ),
                  )
          ],
        ),
      ],
    );
  }
}
