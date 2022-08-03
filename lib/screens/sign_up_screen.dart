import 'package:chatz/widgets/app_bar.dart';
import 'package:chatz/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomAppBar(),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/arrow.png', height: 40),
                      const SizedBox(width: 20),
                      Stack(children: [
                        Container(
                          height: 90,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.5),
                            shape: BoxShape.circle,
                            color: const Color(0xff49b0aa),
                          ),
                          child: Image.asset(
                            'assets/avatar.png',
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5),
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.camera_alt,
                                size: 14,
                              ),
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(width: 20),
                      RotatedBox(
                        quarterTurns: 2,
                        child: Image.asset('assets/arrow.png', height: 40),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const AuthTextField(labelText: 'Username'),
                  const SizedBox(height: 20),
                  const AuthTextField(labelText: 'Email address'),
                  const SizedBox(height: 20),
                  const AuthTextField(labelText: 'Password'),
                  const SizedBox(height: 20),
                  const AuthTextField(labelText: 'Re-type Password'),
                  const Spacer(),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xff9FD7B6),
                      border: Border.fromBorderSide(
                        BorderSide(color: Colors.black),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27),
                        topRight: Radius.circular(27),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Save and Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                            Text(
                              'Your data must be real',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(
                                side: BorderSide(
                                  width: 1.5,
                                  color: Colors.black,
                                ),
                              ),
                              primary: const Color(0xff5EBDE6),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ]),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
