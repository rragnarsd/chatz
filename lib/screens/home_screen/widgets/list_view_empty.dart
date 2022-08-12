part of '../home_screen.dart';

class ListViewEmpty extends StatelessWidget {
  const ListViewEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.noMessagesYet),
            Text(
              '${AppLocalizations.of(context)!.clickOnThePlusButton}!',
            ),
          ],
        ),
      ),
    );
  }
}
