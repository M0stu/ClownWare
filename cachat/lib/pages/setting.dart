import 'package:animations/animations.dart';
import 'package:cachat/pages/personal_info.dart';
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

class setting extends StatefulWidget {
  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  late double _deviceHeight;

  late double _deviceWidth;

  late NavigationService _navigation;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _navigation = GetIt.instance.get<NavigationService>();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Settings'),
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
            //  personal_info(),
              ProfileMenu(
                text: "Personal Information",
                icon: "Assets/icons/privacy-policy.svg",
               press: () {
                   _navigation.navigateToRoute('/personalinfo');
                },
              ),
              ProfileMenu(
                text: "Security",
                icon: "Assets/icons/terms-and-conditions.svg",
                press: () {
                   _navigation.navigateToRoute('/security');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
