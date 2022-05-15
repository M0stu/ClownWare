//Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Widgets
import '../services/database_service.dart';
import '../widgets/custom_Einput_fields.dart';
import '../widgets/custom_passInput_fields.dart';
import '../widgets/or_divider.dart';
import '../widgets/rounded_button.dart';

//providers
import '../providers/authentication_provider.dart';

//Services
import '../services/navigation_service.dart';
import '../widgets/social_icon.dart';

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
  late DatabaseService _db;
  final _loginFormKey = GlobalKey<FormState>();
  late GoogleSignInAccount userObj;
  String? _email;
  String? _password;
  String? _name;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(35),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03,
              vertical: _deviceHeight * 0.02,
            ),
            height: _deviceHeight * 0.98,
            width: _deviceWidth * 0.97,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _pageTitle(),
                SizedBox(
                  height: _deviceHeight * 0.05,
                ),
                _loginForm(),
                SizedBox(
                  height: _deviceHeight * 0.022,
                ),
                _loginButton(),
                SizedBox(
                  height: _deviceHeight * 0.011,
                ),
                const OrDivider(),
                _loginWithGoogleOrFacebook(),
                SizedBox(
                  height: _deviceHeight * 0.03,
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
    return Column(
      children: <Widget>[
        Container(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('Assets/img/cat_icon-01.png'),
            ),
          ),
        ),
        //SizedBox(height: 50.0),
        const Text(
          'Welcome!',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),
        ),
        const Text(
          'Sign in to Continue',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomEmailFormField(
            onSaved: (_value) {
              setState(() {
                print(_value);
                _email = _value;
              });
            },
            regEx:
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
            hintText: "Email",
            obscureText: false,
          ),
          SizedBox(
            height: _deviceHeight * 0.020,
          ),
          CustomPassFormField(
            onSaved: (_value) {
              setState(() {
                _password = _value;
                print(_value);
              });
            },
            regEx: r".{6,}",
            hintText: "Password",
            obscureText: true,
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
        name: "Login",
        height: _deviceHeight * 0.065,
        width: _deviceWidth * 0.65,
        onPressed: () {
          if (_loginFormKey.currentState!.validate()) {
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

  Widget _loginWithGoogleOrFacebook() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          iconSrc: "Assets/icons/facebook.svg",
          press: () async {
            final userCredential = await _auth.signInWithFacebook();
            if (userCredential != null) {
              final idToken = userCredential.user!.getIdToken();
              print(idToken);
              print("User Logged in");
            }
          },
        ),
        SizedBox(
          width: _deviceWidth * 0.15,
        ),
        SocialIcon(
          iconSrc: "Assets/icons/google.svg",
          press: () async {
            await GoogleSignIn().signIn().then((value) {
              setState(() {
                userObj = value!;
              });
            });
            // String? _uid = await _auth.registerUserUsingEmailAndPassword(
            //     userObj.email, userObj.id);
            //
            // await _db.createUser(
            //     _uid!, userObj.email, userObj.displayName!, userObj.photoUrl!);
            // await _auth.logout();
            await _auth.loginUsingEmailAndPassword(userObj.email, userObj.id);
            // _navigation.navigateToRoute('/home');
          },
        ),
      ],
    );
  }

  Widget _registerLink() {
    return Row(
      children: <Widget>[
        const Text(
          'Don\'t have an account?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        TextButton(
          child: const Text(
            'Sign up here',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            _navigation.navigateToRoute('/register');
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
