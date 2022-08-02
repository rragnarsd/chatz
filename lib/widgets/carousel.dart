import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List images;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
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
        });
  }
}
