import 'package:chatz/constants/colors.dart';
import 'package:chatz/screens/auth_screens/widgets/add_image_icon.dart';
import 'package:chatz/widgets/reusable_dialog.dart';
import 'package:flutter/material.dart';

class ProfileImageRow extends StatelessWidget {
  const ProfileImageRow({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/arrow.png',
          height: 40,
        ),
        const SizedBox(width: 20),
        userData['imgUrl'] != null
            ? Stack(children: [
                CircleAvatar(
                  radius: 64,
                  //TODO - green vs black
                  backgroundColor: ConstColors.greenCyan,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userData['imgUrl']),
                    radius: 60,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isDismissible: true,
                          context: context,
                          builder: (context) {
                            return ReusableBottomSheet(
                              fromCamera: () {},
                              fromGallery: () {},
                            );
                          });
                    },
                    child: const AddImageIcon(
                      iconSize: 22,
                      backgroundColor: ConstColors.darkerCyan,
                      iconColor: ConstColors.black87,
                    ),
                  ),
                )
              ])
            : const CircleAvatar(radius: 60),
        const SizedBox(width: 20),
        RotatedBox(
          quarterTurns: 2,
          child: Image.asset(
            'assets/arrow.png',
            height: 40,
          ),
        ),
      ],
    );
  }
}
