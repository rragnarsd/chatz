part of '../landing_screen.dart';

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
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.60,
      child: Stack(children: [
        Positioned(
          top: 30,
          right: 28,
          child: Container(
            height: size.height * 0.1,
            width: size.width * 0.87,
            decoration: UIStyles.carouselDecoration,
          ),
        ),
        Positioned(
          bottom: 30,
          right: 28,
          child: Container(
            height: size.height * 0.1,
            width: size.width * 0.87,
            decoration: UIStyles.carouselDecoration,
          ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.all(40),
            decoration: UIStyles.carouselDecoration.copyWith(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Carousel(images: images),
          ),
        ),
      ]),
    );
  }
}
