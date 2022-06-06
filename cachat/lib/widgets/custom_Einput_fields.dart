import 'package:flutter/material.dart';

class EmailFieldValidator {
  static String? validate(String value) {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)
        ? null
        : 'Enter a valid Email.';
  }
}

class CustomEmailFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String hintText;
  final bool obscureText;

  CustomEmailFormField({
    required this.onSaved,
    required this.hintText,
    required this.obscureText,
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
            keyboardType: TextInputType.emailAddress,
            onSaved: (_value) => onSaved(_value!),
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            obscureText: obscureText,
            validator: (_value) {
              return RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(_value!)
                  ? null
                  : 'Enter a valid Email.';
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.email,
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
