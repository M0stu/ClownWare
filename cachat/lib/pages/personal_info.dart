import 'package:animations/animations.dart';
import 'package:cachat/pages/policy_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../providers/authentication_provider.dart';
import '../services/media_service.dart';
import '../services/navigation_service.dart';
import '../widgets/profile_pic.dart';
import '../widgets/rounded_image.dart';
import '../widgets/top_bar.dart';
import '../widgets/profile_menu.dart';

//Services
import '../services/cloud_storage_service.dart';
import '../services/database_service.dart';

class personal_info extends StatefulWidget {
  @override
  State<personal_info> createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
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
  final _editFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
      _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
  
    return _buildUI();
  }

  Widget _buildUI() {
    late AuthenticationProvider _auth = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('personal information'),
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
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth * 0.03,
            vertical: _deviceHeight * 0.02,
          ),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              personal_infoWidget(),
            /*  ProfileMenu(
                
                  text:("Name  \n" + _auth.user.name + "\n " + "Email \n" + _auth.user.email +"\n" + "Photo \n" + _auth.user.imageURL   ),
             
                icon: "Assets/icons/privacy-policy.svg",
                press: () => {
                  // _navigation.navigateToRoute('/Name'),
                      
                },
              ),
              ProfileMenu(
                text: "Manage Account",
                icon: "Assets/icons/terms-and-conditions.svg",
                press: () {
                  
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }

Widget personal_infoWidget () {
    return Form(
      key: _editFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           
      
           Text(
           "Name\n" + _auth.user.name + "\n",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              
              
            ),
          ),
          SizedBox(
            height: _deviceHeight * 0.020,
          ),
            Text(
           "Email\n" + _auth.user.email +"\n",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 25,
              fontWeight: FontWeight.w600,
               
            ),
          ),
          SizedBox(
            height: _deviceHeight * 0.020,
          ),
          
         
         
        ],
      ),
    );
  }
}