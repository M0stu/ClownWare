//Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Widgets
import '../widgets/custom_input_fields.dart';
import '../widgets/rounded_button.dart';

//providers
import '../providers/authentication_provider.dart';

//Services
import '../services/navigation_service.dart';

class LoginPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    //_auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(35),
          child:Container(
            padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03,
              vertical: _deviceHeight * 0.02,
            ),
            height: _deviceHeight * 0.98,
            width: _deviceWidth * 0.97,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _pageTitle(),
                SizedBox(
                  height: _deviceHeight * 0.04,
                ),
                _loginForm(),
                SizedBox(
                  height: _deviceHeight * 0.12,
                ),
                _loginButton(),
                SizedBox(
                  height: _deviceHeight * 0.02,
                ),
                _registerLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return SizedBox(
      height: _deviceHeight * 0.10,
      child: const Text(
        'CaChat',
        style: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _email = _value;
                });
              },
              regEx: r"^[a-zA-z0-9.a-zA-Z0-9.!#$%&'*+-=?^_`{|}~]+\.[a-zA-Z]+",
              hintText: "Email",
              obscureText: false,
            ),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _password = _value;
                });
              },
              regEx: r".{8,}",
              hintText: "Password",
              obscureText: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
        name: "Login",
        height: _deviceHeight * 0.065,
        width: _deviceHeight * 0.65,
        onPressed: () {
          if (_loginFormKey.currentState!.validate()){
            if (kDebugMode) {
              print("Email: $_email, Password: $_password");
            }
            _loginFormKey.currentState!.save();
            _auth.loginUsingEmailAndPassword(_email!, _password!);
            if (kDebugMode) {
              print("Email: $_email, Password: $_password");
            }

          }
        });
  }

  Widget _registerLink() {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print("Meaaaaaaaaaaaaaaaaw!");
        }
      },
      child: const Text(
        'Meaw, Register!',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
