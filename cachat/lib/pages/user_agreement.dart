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

class UserAgreement extends StatefulWidget {
  @override
  State<UserAgreement> createState() => _UserAgreementState();
}

class _UserAgreementState extends State<UserAgreement> {
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
        title: Text('User Agreement'),
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
              ProfileMenu(
                text: "Privacy Policy",
                icon: "Assets/icons/privacy-policy.svg",
                press: () => {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'privacy_policy.md',
                      );
                    },
                  ),
                },
              ),
              ProfileMenu(
                text: "Terms & Conditions",
                icon: "Assets/icons/terms-and-conditions.svg",
                press: () {
                  showModal(
                    context: context,
                    configuration: const FadeScaleTransitionConfiguration(),
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'terms_and_conditions.md',
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
