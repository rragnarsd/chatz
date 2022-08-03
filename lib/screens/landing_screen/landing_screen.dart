import 'package:chatz/screens/auth_screens/sign_in_screen.dart';
import 'package:chatz/screens/auth_screens/sign_up_screen.dart';
import 'package:chatz/screens/landing_screen/widgets/elevated_btn.dart';
import 'package:chatz/screens/landing_screen/widgets/landing_carousel.dart';
import 'package:flutter/material.dart';

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
                color: Color(0xff9FD7B6),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Column(children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome to Chatz',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.8),
              ),
              const LandingCarousel(),
              const Text(
                'it is for free!',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedBtn(
                text: 'Sign in',
                btnColor: const Color(0xffFFAD85),
                textColor: Colors.black87,
                onTapped: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SignInScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedBtn(
                text: 'Create an Account',
                btnColor: const Color(0xff5EBDE6),
                textColor: Colors.white,
                onTapped: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const SignUpScreen(),
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
