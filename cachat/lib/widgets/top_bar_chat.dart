import 'package:cachat/widgets/rounded_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';

class TopBar extends StatelessWidget {
  String _barTitle;
  Widget? primaryAction;
  Widget? secondaryAction;
  double? fontSize;
  PlatformFile? _profileImage;
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthenticationProvider _auth;
  TopBar(
    this._barTitle, {
    this.primaryAction,
    this.secondaryAction,
    this.fontSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return SizedBox(
      height: _deviceHeight * 0.10,
      width: _deviceWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (secondaryAction != null) secondaryAction!,
              RoundedImageNetworkWithStatusIndicator(
                key: UniqueKey(),
                size: 40,
                imagePath: _auth.user.imageURL,
                isActive: false,
              ),
            ],
          ),
          _titleBar(),
          if (primaryAction != null) primaryAction!,
        ],
      ),
    );
  }

  Widget _titleBar() {
    return Text(
      _barTitle,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
