part of '../profile_screen.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.userData,
    required TextEditingController nameController,
    required this.locale,
  })  : _nameController = nameController,
        super(key: key);

  final dynamic userData;
  final TextEditingController _nameController;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Positioned(
            top: 120,
            left: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: UIStyles.profileDecoration.copyWith(
                color: ConstColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    userData['name'] ?? '',
                    style: TextStyles.style18Bold,
                  ),
                  const SizedBox(height: 20),
                  InfoRow(
                    userData: userData,
                    userKey: '${AppLocalizations.of(context)!.userName}:',
                    userValue: userData['name'] ?? '',
                    isChangeable: true,
                    function: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AppDialog(
                              nameController: _nameController,
                              hintText:
                                  '${AppLocalizations.of(context)!.enterNewName}..',
                              header: AppLocalizations.of(context)!.updateName,
                              onUpdate: () {
                                FirebaseService()
                                    .updateName(_nameController.text)
                                    .then((value) => Navigator.pop(context));
                              },
                            );
                          });
                    },
                  ),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),
                  InfoRow(
                    userData: userData,
                    userKey: '${AppLocalizations.of(context)!.userEmail}:',
                    userValue: userData['email'] ?? '',
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 1),
                  Dropdown(locale: locale),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 60,
            child: ImageRow(userData: userData),
          ),
        ],
      ),
    );
  }
}
