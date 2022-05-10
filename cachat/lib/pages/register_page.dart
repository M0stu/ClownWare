//Packages
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

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
import 'package:cachat/widgets/or_divider.dart';
import 'package:cachat/widgets/social_icon.dart';

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
  String? _name;
  PlatformFile? _profileImage;
  final _registerFormKey = GlobalKey<FormState>();

  //late GoogleSignInAccount userObj;
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => _navigation.navigateToRoute('/login'),
        ),
        backgroundColor:
            Colors.blue.withOpacity(0), //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      resizeToAvoidBottomInset: false,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //  _profileImageField(),
                _pageTitle(),
                SizedBox(
                  height: _deviceHeight * 0.03,
                ),
                _registerForm(),
                SizedBox(
                  height: _deviceHeight * 0.04,
                ),
                _registerButton(),
                // SizedBox(
                //   height: _deviceHeight * 0.015,
                // ),

                //_loginLink(),
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
    return SizedBox(
      height: _deviceHeight * 0.2765,
      child: Form(
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
              hintText: "Username",
              obscureText: false,
              icon: Icons.supervised_user_circle,
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
              height: _deviceHeight * 0.020,
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
            // CustomTextFormField(
            //   onSaved: (_value) {
            //     setState(() {
            //       //_password = _value;
            //     });
            //   },
            //   regEx: r".{8,}",
            //   hintText: "Confirm Password",
            //   obscureText: true,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: _deviceHeight * 0.062,
      width: _deviceWidth * 0.65,
      onPressed: () async {
        if (_registerFormKey.currentState!
                .validate() /*&&
            _profileImage != null*/
            ) {
          _registerFormKey.currentState!.save();
          String? _uid = await _auth.registerUserUsingEmailAndPassword(
              _email!, _password!);

          //String? _imageURL =
          //    await _cloudStorage.saveUserImageToStorage(_uid!, _profileImage!);
          var imgupload = await _cloudStorage.saveUserImageToStorage(_uid!);

          await _db.createUser(_uid, _email!, _name!, "_imageURL!");

          _navigation.goBack();
          await _auth.logout();
          await _auth.loginUsingEmailAndPassword(_email!, _password!);
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
}
