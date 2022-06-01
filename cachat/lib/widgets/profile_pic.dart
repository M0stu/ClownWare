//import 'dart:html';

import 'dart:io';

import 'package:cachat/widgets/rounded_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/authentication_provider.dart';
import '../services/media_service.dart';
import '../services/cloud_storage_service.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  //late File _imageFile;
  late AuthenticationProvider _auth;
  XFile? _profileImage;
  late double _deviceHeight;
  late CloudStorageService _cloudStorage;
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    _cloudStorage = GetIt.instance.get<CloudStorageService>();

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          _auth.user.imageURL != ""
              ? RoundedImageNetwork(
                  key: UniqueKey(),
                  imagePath: _auth.user.imageURL,
                  size: _deviceHeight * 0.15,
                )
              : ProfilePicture(name: _auth.user.name, radius: 50, fontsize: 40),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () async {
                  GetIt.instance
                      .get<MediaService>()
                      .pickImageFromLibrary()
                      .then(
                    (_file) {
                      setState(
                        () {
                          _profileImage = _file;
                        },
                      );
                    },
                  );
                  await _cloudStorage.saveUserImageToStorage(
                      _auth.user.uid, _profileImage);
                  print("hereeeeeeeeeeeeeeeeeeeeeeeeeeee   " +
                      _auth.user.imageURL);
                },
                child: SvgPicture.asset("Assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
