import 'package:chatz/screens/chat_screen/chat_screen.dart';
import 'package:chatz/screens/home_screen/widgets/chat_tile_body.dart';
import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:chatz/widgets/circle_icon_btn.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const ChatSearchBox(
                    hintText: 'Search',
                    isPrefix: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your messages',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.8),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.separated(
                    clipBehavior: Clip.none,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return const ChatTileBody();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ]),
        child: CircleIconBtn(
          btnColor: const Color(0xffFFAD85),
          iconColor: Colors.black,
          height: 56,
          icon: Icons.add,
          onTapped: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
