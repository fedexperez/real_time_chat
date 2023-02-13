import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Text('LO'),
      ),
      title: const Text('item'),
      subtitle: Text('el@correo'),
      trailing: Icon(
        Icons.circle,
        color: Colors.green.shade300,
      ),
    );
  }
}
