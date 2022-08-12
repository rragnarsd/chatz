part of '../landing_screen.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: 20),
        Text(
          '${AppLocalizations.of(context)!.welcomeTo} Chatz',
          style: TextStyles.style18Bold,
        ),
        const LandingCarousel(),
        Text(
          '${AppLocalizations.of(context)!.itIsFree}!',
          style: TextStyles.styleRandomOne,
        ),
        const SizedBox(height: 10),
        ElevatedBtn(
          text: AppLocalizations.of(context)!.signIn,
          btnColor: ConstColors.redOrange,
          textColor: ConstColors.black87,
          onTapped: () => Navigator.pushNamed(
            context,
            AppRouter.signIncreen,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedBtn(
          text: AppLocalizations.of(context)!.register,
          btnColor: ConstColors.lightBlueCyan,
          textColor: ConstColors.white,
          onTapped: () => Navigator.pushNamed(
            context,
            AppRouter.signUpcreen,
          ),
        ),
      ]),
    );
  }
}
