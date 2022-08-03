import 'package:flutter/material.dart';

class SignUpBottomBar extends StatelessWidget {
  const SignUpBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
