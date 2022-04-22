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
//providers

//Widgets
import '../widgets/custom_input_fields.dart';
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
String? _email;
  String? _password;
  String? _name;
PlatformFile? _profileImage;
final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth =MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
       resizeToAvoidBottomInset: false,
       body: Container(
         padding: EdgeInsets.symmetric(
           horizontal:_deviceWidth*0.03,
           vertical: _deviceHeight*0.02,
           ) ,
           height: _deviceHeight*0.98,
           width: _deviceWidth*0.97,
           child:Column(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment:CrossAxisAlignment.center,
             children: [
               _profileImageField(),
                SizedBox(
              height: _deviceHeight * 0.05,
            ),
                _registerForm(),
                 SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _registerButton(),
             SizedBox(
              height: _deviceHeight * 0.02,
            ),
                
             ],
           ),
           ),

    );
   
     
  }
  Widget _profileImageField(){
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
            imagePath: "https://i.pravatar.cc/150?img=66",
            size: _deviceHeight * 0.15,
          );
        }
      }(),
    );

  }
   Widget _registerForm() {
    return Container(
      height: _deviceHeight * 0.35,
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
                hintText: "Name",
                obscureText: false),
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                 _email = _value;
                  });
                },
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: "Email",
                obscureText: false),
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _password = _value;
                  });
                },
                regEx: r".{8,}",
                hintText: "Password",
                obscureText: true),
          ],
        ),
      ),
    );
  }

    Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () async {
      
      },
    );
  }
}