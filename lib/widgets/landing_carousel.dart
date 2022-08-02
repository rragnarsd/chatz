import 'package:flutter/material.dart';

class LandingCarousel extends StatefulWidget {
  const LandingCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingCarousel> createState() => _LandingCarouselState();
}

class _LandingCarouselState extends State<LandingCarousel> {
  List images = [
    'assets/user-cuate.png',
    'assets/user-pana.png',
    'assets/user-rafiki.png'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.55,
      child: Stack(children: [
        Positioned(
          top: 30,
          right: 28,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.87,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(45),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          right: 28,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.87,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(45),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: images.length,
                itemBuilder: (_, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 240,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: List.generate(
                          3,
                          (indexDots) => Container(
                            width: 8,
                            margin: const EdgeInsets.only(bottom: 2),
                            height: index == indexDots ? 27 : 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: index == indexDots
                                  ? const Color(0xff7fac91)
                                  : const Color(0xff9FD7B6),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
