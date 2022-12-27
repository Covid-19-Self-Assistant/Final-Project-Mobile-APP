import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageFromGalleryOrCamera {
  static Future getProfileImage(context, ImagePicker picker) async {
    late bool type;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              MaterialButton(
                onPressed: () {
                  type = true;
                  Navigator.pop(context);
                },
                child: Text('Gallery'),
              ),
              MaterialButton(
                onPressed: () {
                  type = false;
                  Navigator.pop(context);
                },
                child: Text('Camera'),
              ),
            ],
            content: Container(
              height: 60,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'Which option your prefered',
                      style: TextStyle(
                          color: Colors.blue[900], fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    XFile? pickedFile;
    if (type) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }
    print(pickedFile);

    return pickedFile;
  }
}
