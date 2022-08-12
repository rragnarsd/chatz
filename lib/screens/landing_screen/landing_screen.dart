import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:chatz/constants/colors.dart';
import 'package:chatz/constants/text_styles.dart';
import 'package:chatz/constants/ui_styles.dart';
import 'package:chatz/routes/router.dart';

part 'widgets/carousel.dart';
part 'widgets/elevated_btn.dart';
part 'widgets/landing_carousel.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: ConstColors.greenCyan,
                border: Border(
                  bottom: BorderSide(
                    color: ConstColors.black,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
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
                  onTapped: () =>
                      Navigator.pushNamed(context, AppRouter.signIncreen),
                ),
                const SizedBox(height: 20),
                ElevatedBtn(
                  text: AppLocalizations.of(context)!.register,
                  btnColor: ConstColors.lightBlueCyan,
                  textColor: ConstColors.white,
                  onTapped: () =>
                      Navigator.pushNamed(context, AppRouter.signUpcreen),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
