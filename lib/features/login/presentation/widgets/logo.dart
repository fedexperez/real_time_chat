import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Container(
              height: size.height * 0.15,
              margin: const EdgeInsets.only(bottom: 10),
              child: const Image(
                image: AssetImage('assets/icon/tag-logo.png'),
              ),
            ),
            const Text('Messenger', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
