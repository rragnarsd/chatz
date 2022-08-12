part of '../profile_screen.dart';

class ImageRow extends StatefulWidget {
  const ImageRow({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final dynamic userData;

  @override
  State<ImageRow> createState() => _ImageRowState();
}

class _ImageRowState extends State<ImageRow> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/arrow.png',
          height: 40,
        ),
        const SizedBox(width: 20),
        widget.userData['imgUrl'] != null
            ? Stack(children: [
                Container(
                  decoration: UIStyles.profileDecorationAvatar,
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: ConstColors.greenCyan,
                    child: Hero(
                      tag: 'userImg',
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: pickedImage == null
                            ? NetworkImage(widget.userData['imgUrl'])
                                as ImageProvider
                            : FileImage(pickedImage!),
                      ),
                    ),
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
                            return AppBottomSheet(
                              fromCamera: () async {
                                await pickImageFromCamera()
                                    .then((value) => Navigator.pop(context));
                                if (pickedImage != null) {
                                  var imagePath = await FirebaseService()
                                      .uploadImageToStorage(pickedImage!);
                                  FirebaseService().updateImg(imagePath!);
                                }
                              },
                              fromGallery: () async {
                                await pickImageFromGallery()
                                    .then((value) => Navigator.pop(context));

                                if (pickedImage != null) {
                                  var imagePath = await FirebaseService()
                                      .uploadImageToStorage(pickedImage!);
                                  FirebaseService().updateImg(imagePath!);
                                }
                              },
                            );
                          });
                    },
                    child: const AddImageIcon(
                      iconSize: 20,
                      backgroundColor: ConstColors.white,
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

  Future pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = File(image!.path);
    });
  }

  Future pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(image!.path);
    });
  }
}
