import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  String imageName = "";
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  var descriptionC = TextEditingController();
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String colletionName = "Image";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: double.infinity,
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: Get.width * 0.3,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: Get.width * 0.4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        const SizedBox(height: 60),

                        Text(
                          "Change Profile",
                          style: GoogleFonts.montserrat(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        imageName == "" ? Container() : Text(imageName),
                        const SizedBox(height: 5),
                        OutlinedButton(
                          onPressed: () {
                            imagePicker();
                          },
                          child: const Text("Select Image"),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: descriptionC,
                          minLines: 3,
                          maxLines: 5,
                          decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder()),
                        ),
                        // OutlinedButton(onPressed: () {}, child: Text('Random'))
                        const SizedBox(height: 15),
                        ElevatedButton(
                            onPressed: () {
                              // Upload Picture
                              _uploadImage();
                            },
                            child: const Text('Upload')),
                      ],
                    ),
            ),
          ]),
        ),
      ),
    );
  }

  _uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    var uniqueKey = firestoreRef.collection(colletionName);
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference ref = storageRef.ref().child(colletionName).child(uploadFileName);
    UploadTask uploadTask = ref.putFile(File(imagePath!.path));
    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          "\t" +
          event.totalBytes.toString());
    });
    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
      // Will Insert Record to Firestore
      if (uploadPath.isNotEmpty) {
        firestoreRef.collection(colletionName).doc(uniqueKey.id).set({
          "description": descriptionC.text,
          "image": uploadPath,
        }).then((value) => _showMessage("Record Inserted"));
      } else {
        _showMessage("Something went wrong while uploading image.");
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
        descriptionC.text = Faker().lorem.sentence();
      });
    }
  }
}
