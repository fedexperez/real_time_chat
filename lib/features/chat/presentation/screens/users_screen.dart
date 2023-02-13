import 'package:flutter/material.dart';

import 'package:real_time_chat/features/chat/presentation/widgets/custom_list_view.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My name'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app_rounded),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            // child: const Icon(
            //   Icons.check_circle,
            //   color: Colors.blueAccent,
            // ),
            child: const Icon(
              Icons.offline_bolt,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: CustomListView(),
    );
  }
}
