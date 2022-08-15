import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImgProvider extends ChangeNotifier {
  File? _pickedImage;

  File? get pickedImage => _pickedImage;

  Future pickImageFromCamera(image) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    try {
      _pickedImage = File(image!.path);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future pickImageFromGallery(image) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    try {
      _pickedImage = File(image!.path);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
