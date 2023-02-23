import 'package:flutter/material.dart';

class CustomFilledFormButton extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;

  const CustomFilledFormButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
