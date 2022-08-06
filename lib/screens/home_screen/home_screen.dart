import 'package:chatz/constants/colors.dart';
import 'package:chatz/screens/home_screen/widgets/chat_tile_body.dart';
import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:chatz/screens/profile_screen/profile_screen.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:chatz/widgets/circle_icon_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  dynamic data;
  String? message;
  String search = '';
  String? imgUrl;

  @override
  void initState() {
    FirebaseService().getUserData().then((value) {
      data = value;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Your Chatz'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: ConstColors.darkerCyan,
                  backgroundImage:
                      data == null ? null : NetworkImage(data['imgUrl']),
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ChatSearchBox(
                      hintText: 'Search',
                      isPrefix: const Icon(Icons.search),
                      function: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Text(
                      'Your messages',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder(
                    stream: firestore.collection('chatz').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Text('You don\'t have any groups yet');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: snapshot.data!.docs.where((element) {
                            return element.id.contains(search);
                          }).length,
                          itemBuilder: (context, index) {
                            return ChatTileBody(
                              stream: snapshot.data!.docs
                                  .where((element) {
                                    return element.id.contains(search);
                                  })
                                  .toList()[index]
                                  .reference
                                  .collection('messages')
                                  .snapshots(),
                              title: snapshot.data!.docs
                                  .where((element) {
                                    return element.id.contains(search);
                                  })
                                  .toList()[index]
                                  .id,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
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
          btnColor: ConstColors.redOrange,
          iconColor: Colors.black,
          height: 56,
          icon: Icons.add,
          onTapped: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: const Text('Create group'),
                      content: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter name..',
                        ),
                        onChanged: (groupName) {
                          setState(() {
                            message = groupName;
                          });
                        },
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  side: const BorderSide(width: 1),
                                  primary: ConstColors.redOrange),
                              onPressed: () {
                                firestore
                                    .collection('chatz')
                                    .doc(message)
                                    .collection('messages')
                                    .add({
                                  'sender': auth.currentUser!.email,
                                  'message': 'New group created!',
                                  'time':
                                      DateFormat('hh:mm').format(DateTime.now())
                                });
                                firestore
                                    .collection('chatz')
                                    .doc(message)
                                    .set({'status': 'active'});
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: ConstColors.black,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        )
                      ]);
                });
          },
        ),
      ),
    );
  }
}
