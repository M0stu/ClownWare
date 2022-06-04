//Packages
import 'package:cachat/pages/policy_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';

//Services
import 'package:cachat/services/media_service.dart';
import 'package:cachat/services/database_service.dart';
import 'package:cachat/services/cloud_storage_service.dart';
import 'package:cachat/services/navigation_service.dart';

//Widgets
import '../widgets/custom_Einput_fields.dart';
import '../widgets/custom_input_fields.dart';
import '../widgets/custom_passInput_fields.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_image.dart';

//providers
import '../providers/authentication_provider.dart';

//Pages

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthenticationProvider _auth;
  late DatabaseService _db;
  late CloudStorageService _cloudStorage;
  late NavigationService _navigation;
  String? _email;
  String? _password;
  String? _cPassword;
  String? _name;
  PlatformFile? _profileImage;
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    //Widget okButton =
    //AlertDialog alert =
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => _navigation.goBack(),
        ),
        backgroundColor:
            Colors.blue.withOpacity(0), //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(35),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03,
              vertical: _deviceHeight * 0.02,
            ),
            height: _deviceHeight,
            width: _deviceWidth,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _pageTitle(),
                SizedBox(
                  height: _deviceHeight * 0.03,
                ),
                _registerForm(),
                privacyPolicyLinkAndTermsOfService(),
                SizedBox(
                  height: _deviceHeight * 0.04,
                ),
                _registerButton(),
                SizedBox(
                  height: _deviceHeight * 0.030,
                ),
                _loginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then(
          (_file) {
            setState(
              () {
                _profileImage = _file;
              },
            );
          },
        );
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
            key: UniqueKey(),
            image: _profileImage!,
            size: _deviceHeight * 0.15,
          );
        } else {
          return RoundedImageNetwork(
            key: UniqueKey(),
            imagePath: "https://i.pravatar.cc/150?img=56",
            size: _deviceHeight * 0.15,
          );
        }
      }(),
    );
  }

  Widget _registerForm() {
    return Form(
      key: _registerFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextFormField(
            onSaved: (_value) {
              setState(() {
                _name = _value;
              });
            },
            regEx: r'.{8,}',
            hintText: "Name",
            obscureText: false,
            icon: Icons.account_circle,
          ),
          SizedBox(
            height: _deviceHeight * 0.020,
          ),
          CustomEmailFormField(
            onSaved: (_value) {
              setState(() {
                _email = _value;
              });
            },
            regEx:
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
            hintText: "Email",
            obscureText: false,
          ),
          SizedBox(
            height: _deviceHeight * 0.025,
          ),
          CustomPassFormField(
            onSaved: (_value) {
              setState(() {
                _password = _value;
              });
            },
            regEx: r".{8,}",
            hintText: "Password",
            obscureText: true,
          ),
          SizedBox(
            height: _deviceHeight * 0.020,
          ),
          CustomPassFormField(
            onSaved: (_value) {
              setState(() {
                _cPassword = _value;
              });
            },
            regEx: r".{8,}",
            hintText: "Confirm Password",
            obscureText: true,
          ),
        ],
      ),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: _deviceHeight * 0.062,
      width: _deviceWidth * 0.65,
      onPressed: () async {
        if (_registerFormKey.currentState!.validate() &&
            _password == _cPassword) {
          _registerFormKey.currentState!.save();
          String? _uid = await _auth.registerUserUsingEmailAndPassword(
              _email!, _password!);
          // String? _imageURL =
          //     await _cloudStorage.saveUserImageToStorage(_uid!, _profileImage!);
          await _db.createUser(_uid!, _email!, _name!, "");

          await _auth.logout();
          await _auth.loginUsingEmailAndPassword(_email!, _password!);
        } else {
          showAlert();
        }
      },
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
        const Text(
          'Welcome!',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),
        ),
        const Text(
          'Create Your Account',
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _loginLink() {
    return Row(
      children: <Widget>[
        const Text(
          'Already have an account?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        TextButton(
          child: const Text(
            'Sign in here',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: () {
            _navigation.navigateToRoute('/login');
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Future showAlert() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Credentials Check",
            style: TextStyle(fontSize: 25, color: Colors.white54),
          ),
          content: const Text("Please Check the Credentials You have entered!",
              style: TextStyle(fontSize: 18, color: Colors.white)),
          backgroundColor: Colors.indigo,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          //contentPadding: EdgeInsets.zero,
          actions: [
            TextButton(
              child: const Text("OK",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget privacyPolicyLinkAndTermsOfService() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: 'By continuing, you agree to our ',
            style: const TextStyle(fontSize: 12, color: Colors.white54),
            children: <TextSpan>[
              TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showModal(
                        context: context,
                        configuration: const FadeScaleTransitionConfiguration(),
                        builder: (context) {
                          return PolicyDialog(
                            mdFileName: 'terms_and_conditions.md',
                          );
                        },
                      );
                    }),
              TextSpan(
                text: ' and ',
                style: const TextStyle(fontSize: 12, color: Colors.white54),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PolicyDialog(
                              mdFileName: 'privacy_policy.md',
                            );
                          },
                        );
                      },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
