import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  final IconData icon;
  CustomTextFormField({
    required this.onSaved,
    required this.regEx,
    required this.hintText,
    required this.obscureText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(30, 29, 37, 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        onSaved: (_value) => onSaved(_value!),
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        obscureText: obscureText,
        validator: (_value) {
          return RegExp(regEx).hasMatch(_value!)
              ? null
              : 'Enter a valid value.';
        },
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white54),
        ),
      ),
    );
  }
}
