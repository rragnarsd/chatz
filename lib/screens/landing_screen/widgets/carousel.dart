part of '../landing_screen.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List images;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CarouselImage(
                size: size,
                images: images,
                imgUrl: images[index],
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
                          ? ConstColors.darkerCyan
                          : ConstColors.greenCyan,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}

class CarouselImage extends StatelessWidget {
  const CarouselImage({
    Key? key,
    required this.size,
    required this.images,
    required this.imgUrl,
  }) : super(key: key);

  final Size size;
  final List images;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (size.width <= 360)
          ? size.width * 0.45
          : (size.width <= 400)
              ? size.width * 0.53
              : size.width * 0.55,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
