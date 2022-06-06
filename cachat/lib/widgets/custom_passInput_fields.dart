import 'package:flutter/material.dart';

class PasswordFieldValidator {
  static String? validate(String value) {
    return RegExp(r".{8,}").hasMatch(value) ? null : 'Enter a valid Password.';
  }
}

class CustomPassFormField extends StatefulWidget {
  final Function(String) onSaved;
  final String hintText;
  final bool obscureText;

  CustomPassFormField({
    required this.onSaved,
    required this.hintText,
    required this.obscureText,
  });

  @override
  State<CustomPassFormField> createState() => _CustomPassFormFieldState();
}

class _CustomPassFormFieldState extends State<CustomPassFormField> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

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
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_passwordVisible,
            onSaved: (_value) => widget.onSaved(_value!),
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            validator: (_value) {
              PasswordFieldValidator.validate(_value!);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 15.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                splashRadius: 1,
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.indigo,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              border: InputBorder.none,
              hintText: widget.hintText,
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
