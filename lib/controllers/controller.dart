import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbookapp/data/models/popularModel.dart';
import 'package:newbookapp/pages/home.dart';
import 'package:newbookapp/pages/login.dart';

import '../data/global.dart';

class AuthController extends GetxController {
// Instance
  static AuthController instance = Get.find();
  // Email, password, namw...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  var hidden = true.obs;
  var rememberMe = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // user will be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  // Sign In With Email and Password
  Future<void> login(String email, password) async {
    try {
      CollectionReference _user = firestore.collection('user');
      DocumentReference _doc = _user.doc(email);

      Map<String, dynamic> user = <String, dynamic>{
        "email": email,
        "password": password,
      };
      await _doc.set(user).whenComplete(
            () => auth.signInWithEmailAndPassword(
                email: email, password: password),
          );
    } catch (e) {
      Get.snackbar(
        "About Login",
        "Login Message",
        backgroundColor: color1,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Login Failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void signIn(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About Login",
        "Login Message",
        backgroundColor: color1,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Login Failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: const Text(
          "Please enter the right input",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  // Sign Up With Email and Password
  Future<void> register(String email, password) async {
    try {
      CollectionReference _user = firestore.collection('user');
      DocumentReference _doc = _user.doc(email);

      Map<String, dynamic> user = <String, dynamic>{
        "email": email,
        "password": password,
        "imageUrl": null,
        "review": [
          {"rating": null, "review": null}
        ],
        "borrow": [],
      };
      await _doc.set(user).whenComplete(
            () => auth.createUserWithEmailAndPassword(
                email: email, password: password),
          );
    } catch (e) {
      print(e);
      Get.snackbar(
        "About Register",
        "Register Message",
        backgroundColor: color1,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Register Failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: const Text(
          "Please enter the right input",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  // Sign Out
  void logOut() async {
    await auth.signOut();
  }

  //Simpan peminjaman
  //Akses ke firestore
  Future<void> addBorrow(String day) async {
    CollectionReference _user = firestore.collection('user');

    DocumentReference _doc = _user.doc(auth.currentUser!.email);

    Map<String, dynamic> data = <String, dynamic>{
      "borrow": [
        {
          "day": day,
        }
      ]
    };
    await _doc
        .update(data)
        .whenComplete(() => print("Borrow Success"))
        .catchError((e) => print("Error Borrow: $e"));
  }

  // Simpan Rating
  // Akses kedalam firestore
  Future<void> addRating(int rating, String review) async {
    CollectionReference _review = firestore.collection('review');

    DocumentReference _doc = _review.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "rating": rating,
      "review": review,
    };
    await _doc
        .set(data)
        .whenComplete(() => print("Rating Added"))
        .catchError((e) => print("Failed to add rating: $e"));
  }

  Future<void> tambahRating(int rating, String review) async {
    CollectionReference _user = firestore.collection('user');
    DocumentReference _doc = _user.doc(auth.currentUser!.email);

    Map<String, dynamic> data = <String, dynamic>{
      "review": [
        {
          "rating": rating,
          "review": review,
        }
      ]
    };
    await _doc
        .update(data)
        .whenComplete(() => print("Rating Added"))
        .catchError((e) => print("Failed to add rating: $e"));
  }

  // Akses ke dalam Firebase Storage
  final FirebaseStorage storage = FirebaseStorage.instance;
  // Future<void> uploadFile() async {

  //   String uploadFileName =
  //       DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
  //   Reference ref = storage.ref().child('user').child(uploadFileName);
  //   UploadTask uploadTask = ref.putFile(File? (imagePath!.path));
  //   try {
  //     await storage.ref('userPhoto/').putFile(file);
  //   } on FirebaseException catch (e) {
  //     print(e);
  //   }
  // }

  Future<ListResult> listFiles() async {
    ListResult result = await storage.ref('book').listAll();

    for (var ref in result.items) {
      print('Found file: $ref');
    }
    return result;
  }

  Future<String> getUrl(String imageName) async {
    String downloadUrl = await storage.ref('book/$imageName').getDownloadURL();
    print(downloadUrl);

    return downloadUrl;
  }

  static const String popularUrl =
      'http://10.0.2.2:5000/recommendation/popular-based';

  // Fetch data from JSON file
  static Future<Object> getPopular() async {
    try {
      final response = await http.get(Uri.parse(popularUrl));
      if (200 == response.statusCode) {
        final PopularModel popular = popularModelFromJson(response.body);
        return popular;
      } else {
        return PopularModel;
      }
    } catch (e) {
      return PopularModel;
    }
  }
}
// var isAuth = false.obs;

  // Map<String, String> _dataUser = {
  //   'email': 'admin@gmail.com',
  //   'password': 'admin',
  // };

  // void dialogError(String msg) {
  //   Get.defaultDialog(
  //     title: "Terjadi Kesalahan",
  //     middleText: msg,
  //   );
  // }

  // Future<void> autoLogin() async {
  //   final box = GetStorage();
  //   if (box.read("dataUser") != null) {
  //     final data = box.read("dataUser") as Map<String, dynamic>;
  //     login(data["email"], data["password"], data["rememberMe"]);
  //   }
  // }

  // void login(String email, String pass, bool rememberMe) async {
  //   if (email != '' && pass != '') {
  //     // ....
  //     if (GetUtils.isEmail(email)) {
  //       if (email == _dataUser['email'] && pass == _dataUser['password']) {
  //         if (rememberMe) {
  //           // Simpan data ke Get Storage
  //           final box = GetStorage();
  //           box.write(
  //             "dataUser",
  //             {
  //               "email": email,
  //               "password": pass,
  //               "rememberMe": rememberMe,
  //             },
  //           );
  //         } else {
  //           // Hapus Storage
  //           final box = GetStorage();
  //           if (box.read('dataUser') != null) {
  //             box.erase();
  //           }
  //         }
  //         // Berhasil Login
  //         isAuth.value = true;
  //       } else {
  //         dialogError("Data tidak valid. Gunakan akun lainnya");
  //       }
  //     } else {
  //       dialogError("Email tidak valid");
  //     }
  //   } else {
  //     dialogError("Isikan data di kolom tersedia");
  //   }
  // }

  // void logout(bool rememberMe) {
  //   if (rememberMe == false) {
  //     final box = GetStorage();
  //     if (box.read("dataUser") != null) {
  //       box.erase();
  //     }
  //   }
  // }
