import 'package:chatz/screens/shared/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size.height * 0.75,
        width: size.width * 0.9,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: 4,
          itemBuilder: (context, index) {
            return ShimmerLoading.rectangular(height: 80);
          },
        ),
      ),
    );
  }
}
