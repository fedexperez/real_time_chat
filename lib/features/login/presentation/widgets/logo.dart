import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String? title;

  const Logo({super.key, this.title = 'Messenger'});

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
            Text(title!, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
