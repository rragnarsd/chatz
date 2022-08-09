import 'package:chatz/data/models/user_model.dart';
import 'package:chatz/screens/home_screen/widgets/search_box.dart';
import 'package:chatz/services/firebase.dart';
import 'package:chatz/widgets/app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchName = '';
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Search'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: ChatSearchBox(
                controller: controller,
                hintText: 'Search',
                isPrefix: const Icon(Icons.search),
                function: (value) {
                  setState(() {
                    FirebaseService().searchUsers(controller.text);
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<QuerySnapshot>(
                future: FirebaseService().searchUsers(controller.text),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                UserModel model = UserModel.fromJson(
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>,
                                );

                                return ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 20),
                                  title: Text(model.name ?? ''),
                                  leading: Image.network(
                                    model.imgUrl ??
                                        'https://storyset.com/illustration/curly-hair/pana',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }),
                        )
                      : const Center(
                          child: Text('No friends yet'),
                        );
                })
          ],
        ),
      ),
    );
  }
}
