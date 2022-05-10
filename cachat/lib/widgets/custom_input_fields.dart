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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: size.width * 0.85,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(30, 29, 37, 1.0),
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: 65.0,
          child: TextFormField(
            keyboardType: TextInputType.name,
            onSaved: (_value) => onSaved(_value!),
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            obscureText: obscureText,
            validator: (_value) {
              return RegExp(regEx).hasMatch(_value!)
                  ? null
                  : 'Enter a valid Username.';
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white,
              ),
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.white54,
                fontFamily: 'OpenSans',
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
