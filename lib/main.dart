import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:chatz/L10n/l10n.dart';
import 'package:chatz/providers/img_provider.dart';
import 'package:chatz/providers/locale_provider.dart';
import 'package:chatz/routes/router.dart';
import 'package:chatz/screens/home_screen/home_screen.dart';
import 'package:chatz/screens/landing_screen/landing_screen.dart';
import 'package:chatz/screens/shared/widgets/dismiss_keyboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.appRouter}) : super(key: key);

  final Route? appRouter;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 153, 204, 174),
        statusBarBrightness: Brightness.light,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImgProvider(),
        )
      ],
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return DismissKeyboard(
          child: MaterialApp(
            title: 'Chatz',
            theme: ThemeData(
              primarySwatch: Colors.green,
              textTheme: GoogleFonts.sarabunTextTheme(),
            ),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: provider.locale,
            supportedLocales: L10n.all,
            home: const MainBody(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        );
      },
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LandingScreen();
        }
      },
    );
  }
}
