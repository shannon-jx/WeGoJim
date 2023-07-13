// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wegojim/reset_pw_page.dart';

import 'components/select_pfp_sheet.dart';
import 'edit_profile_page.dart';
import 'package:path_provider/path_provider.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final useremail = FirebaseAuth.instance.currentUser?.email;
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        _saveImageLocally(img);
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<void> _saveImageLocally(File? image) async {
  final appDir = await getApplicationDocumentsDirectory();
  final fileName = 'profile_image.jpg';
  final localPath = '${appDir.path}/$fileName';
  await image?.copy(localPath);
  // Now the image file is saved locally at 'localPath'
}

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPfpSheet(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.red),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            color: Colors.red,
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(useremail!)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
                      child: Center(
                        child: Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child: _image == null
                                  ? const Text(
                                      'No image selected',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(_image!),
                                      radius: 200.0,
                                    ),
                            )),
                      ),
                    ),
                  ),
                  Center(
                    child: ProfileInfo(
                      label: '',
                      value: userData['Name'],
                    ),
                  ),
                  Center(
                    child: ProfileInfo(
                      label: '',
                      value: userData['Email'],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Row(
                      children: [
                        const SizedBox(height: 16.0, width: 50.0,),
                        ProfileInfo(
                          label: 'Height (cm)',
                          value: userData['Height'],
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 20.0,
                        ),
                        ProfileInfo(
                          label: 'Weight (kg)',
                          value: userData['Weight'],
                        ),
                        const SizedBox(
                          height: 16.0,
                          width: 20.0,
                        ),
                        ProfileInfo(
                          label: 'BMI',
                          value: (double.parse(userData['Weight']) /
                                  (double.parse(userData['Height'])/100)* (double.parse(userData['Height'])/100))
                              .toStringAsFixed(1),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPWPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 16),
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
