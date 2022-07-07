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

class PersonalInfo extends StatefulWidget {
  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  final _editFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return _buildUI();
  }

  Widget _buildUI() {
    late AuthenticationProvider _auth =
        Provider.of<AuthenticationProvider>(context);

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
            ],
          ),
        ),
      ),
    );
  }

  Widget personal_infoWidget() {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _editFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Name",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 22,
              //fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(30, 29, 37, 1.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            height: 65.0,
            child: Text(
              _auth.user.name,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: _deviceHeight * 0.020,
          ),
          const Text(
            "Your Email",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(30, 29, 37, 1.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            height: 65.0,
            child: Text(
              _auth.user.email,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
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
