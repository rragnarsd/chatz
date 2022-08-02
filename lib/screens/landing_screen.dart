import 'package:chatz/widgets/landing_carousel.dart';
import 'package:chatz/widgets/elevated_btn.dart';
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
            Column(children: const [
              SizedBox(height: 20),
              Text(
                'Welcome to Chatz',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    letterSpacing: 0.8),
              ),
              LandingCarousel(),
              Text(
                'it is for free!',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(height: 10),
              ElevatedBtn(
                text: 'Sign in',
                btnColor: Color(0xffFFAD85),
                textColor: Colors.black87,
              ),
              SizedBox(height: 20),
              ElevatedBtn(
                text: 'Create an Account',
                btnColor: Color(0xff5EBDE6),
                textColor: Colors.white,
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
