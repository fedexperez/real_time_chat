import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData iconData;
  final String? hintText;
  final TextInputType? textInputType;
  final TextEditingController textController;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.iconData,
    this.hintText,
    this.textInputType,
    required this.textController,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.only(right: 20, left: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        autocorrect: false,
        controller: textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          prefixIcon: Icon(iconData),
        ),
        keyboardType: textInputType,
        obscureText: obscureText,
      ),
    );
  }
}
