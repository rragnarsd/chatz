import 'package:chatz/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: GridView.builder(
          itemCount: 6,
          padding: const EdgeInsets.only(bottom: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return ShimmerLoading.rectangular(height: 180);
          },
        ),
      ),
    );
  }
}
