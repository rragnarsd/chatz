part of '../search_screen.dart';

class SearchResult extends StatelessWidget {
  const SearchResult(
      {Key? key,
      required this.auth,
      required this.chatUser,
      required this.imgUrl,
      required this.name,
      required this.email})
      : super(key: key);

  final FirebaseAuth auth;
  final String chatUser;
  final String imgUrl;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.chatScreen,
          arguments: ChatScreenArguments(
            chatUser: chatUser,
            currentUser: auth.currentUser!.uid,
            name: name,
            imgUrl: imgUrl,
          ),
        );
      },
      child: Stack(
        children: [
          Positioned(
            left: size.width <= 360 ? 3 : 5,
            right: size.width <= 360 ? 0 : 4,
            top: size.width <= 360 ? 28 : 8,
            child: Container(
              height: 180,
              decoration: UIStyles.chatDecoration.copyWith(
                color: ConstColors.lightShadeOrange,
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 13,
            child: Container(
              height: 180,
              width: size.width * 0.4,
              padding: const EdgeInsets.all(10),
              decoration: UIStyles.chatDecoration.copyWith(
                color: ConstColors.white,
              ),
              child: Column(children: [
                Container(
                  width: 140,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5),
                    borderRadius: BorderRadius.circular(13),
                    image: DecorationImage(
                      image: NetworkImage(
                        imgUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyles.style14,
                    ),
                    const SizedBox(width: 10),
                    const FaIcon(
                      FontAwesomeIcons.comment,
                      color: ConstColors.redOrange,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  email,
                  style: TextStyles.style14Bold,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
