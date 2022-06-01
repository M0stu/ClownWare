import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class MediaService {
  MediaService() {}
  final ImagePicker _picker = ImagePicker();
  Future<XFile?> pickImageFromLibrary() async {
    XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      return _image;
    }
    return null;
  }
}
