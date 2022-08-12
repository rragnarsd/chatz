import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  ShimmerLoading.rectangular(
      {Key? key, this.width = double.infinity, required this.height})
      : border =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        super(key: key);

  const ShimmerLoading.circular(
      {Key? key,
      required this.width,
      required this.height,
      this.border = const CircleBorder()})
      : super(key: key);

  final double width;
  final double height;
  final ShapeBorder border;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.grey[400]!,
          shape: border,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
