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
import './user_agreement.dart';
//Services
import '../services/cloud_storage_service.dart';
import '../services/database_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late double _deviceHeight;

  late double _deviceWidth;

  late AuthenticationProvider _auth;

  late NavigationService _navigation;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();

    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
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
          TopBar(
            'Profile',
          ),
          ProfilePic(),
          const SizedBox(height: 15),
          Text(
            _auth.user.name,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 25),
          ProfileMenu(
            text: "Account Settings",
            icon: "Assets/icons/User Icon.svg",
            press: () => {_navigation.navigateToRoute('/accSetting')},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "Assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "User Agreement",
            icon: "Assets/icons/user-agreement.svg",
            press: () {
              _navigation.navigateToRoute('/userAG');
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "Assets/icons/Log out.svg",
            press: () {
              _auth.logout();
            },
          ),
        ],
      ),
    );
  }
}
