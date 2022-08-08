import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Search'),
        actions: const [],
      ),
      body: SafeArea(
          child: SizedBox(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ChatSearchBox(
            hintText: 'Search',
            isPrefix: const Icon(Icons.search),
            function: (value) {},
          ),
        ),
      )),
    );
  }
}
