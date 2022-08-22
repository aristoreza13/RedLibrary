import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newbookapp/controllers/controller.dart';
import 'package:newbookapp/data/global.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;

  final c = Get.find<AuthController>();
  bool _isLoading = false;
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  String imageName = "";
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Profile",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  // Profile Image
                  // TODO: FIX PROFILE PAGE
                  Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      width: 175,
                      height: 175,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/newbookapp-85e51.appspot.com/o/userPhoto%2F1645414044070.jpg?alt=media&token=2f7b5d51-bb1a-4c87-a5d5-ef21fd0c1424",
                          fit: BoxFit.fill,
                        ),
                      )
                      // FutureBuilder<QuerySnapshot>(
                      //   future: firestore.collection('user').get(),
                      //   builder: ((context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     } else if (snapshot.hasData &&
                      //         snapshot.data!.docs.length > 0) {
                      //       List<DocumentSnapshot> arrData = snapshot.data!.docs;
                      //       print(arrData.length);
                      //       print(arrData[2]['imageUrl']);
                      //       return ListView.builder(
                      //         itemCount: arrData.length,
                      //         itemBuilder: (context, index) {
                      //           return ClipRRect(
                      //             borderRadius: BorderRadius.circular(200),
                      //             child: Image.network(
                      //               arrData[2]['imageUrl'],
                      //               fit: BoxFit.cover,
                      //             ),
                      //           );
                      //         },
                      //       );
                      //     } else {
                      //       return ClipRRect(
                      //         borderRadius: BorderRadius.circular(200),
                      //         child: Image.asset(
                      //           "assets/images/noimage.png",
                      //           fit: BoxFit.cover,
                      //         ),
                      //       );
                      //     }
                      //   }),
                      // ),
                      ),

                  // Change Profile Picture
                  // ElevatedButton(
                  //   onPressed: () {
                  //     _uploadImage();
                  //     // CollectionReference uid = firestore.collection('user');
                  //     // print(uid.doc(user!.email));
                  //   },
                  //   child: Text("Change Photo"),
                  // ),
                  // User logged in right now
                  Text(
                    user!.email!,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  // Favorited | Reviewed Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Favorited",
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "2",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 80,
                        width: 160,
                        // color: color2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Reviewed",
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "2",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Update Profile
                  // ListTile(
                  //   onTap: () => Get.to(() => ChangeProfile()),
                  //   leading: Icon(Icons.note_add_outlined),
                  //   title: Text(
                  //     "Perbarui Data Profil",
                  //     style: GoogleFonts.montserrat(
                  //       fontSize: 22,
                  //     ),
                  //   ),
                  //   trailing: Icon(Icons.arrow_right),
                  // ),
                  const SizedBox(height: 30),
                  // Sign Out
                  GestureDetector(
                    onTap: () => c.logOut(),
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.5,
                      decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color1, color2],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Out",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Text("@Book App V.1.0")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
      });
    }

    CollectionReference uniqueKey = firestore.collection('user');
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
    Reference ref = storage.ref().child('userPhoto').child(uploadFileName);
    UploadTask uploadTask = ref.putFile(File(imagePath!.path));
    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          "\t" +
          event.totalBytes.toString());
    });
    try {
      await uploadTask.whenComplete(() async {
        var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();
        if (uploadPath.isNotEmpty) {
          uniqueKey.doc(user!.email).update({
            "imageUrl": uploadPath,
          }).then((value) => _showMessage("Record Inserted."));
        } else {}
      });
    } on FirebaseException catch (e) {
      print(e);
    }
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
      });
    }
  }
}
