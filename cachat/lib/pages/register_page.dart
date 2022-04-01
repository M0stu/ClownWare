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
//widgets

class registerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<registerPage> {
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold();
  }
}
