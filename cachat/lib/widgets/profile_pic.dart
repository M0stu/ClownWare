import 'package:cachat/widgets/rounded_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../services/media_service.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  PlatformFile? _profileImage;
  late double _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          _profileImage != null
              ? RoundedImageFile(
                  key: UniqueKey(),
                  image: _profileImage!,
                  size: _deviceHeight * 0.15,
                )
              : RoundedImageNetwork(
                  key: UniqueKey(),
                  imagePath: "https://i.pravatar.cc/150?img=56",
                  size: _deviceHeight * 0.15,
                ),
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
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
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
