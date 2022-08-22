import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginC extends GetxController {
  var rememberMe = false.obs;
  var hidden = true.obs;
  late TextEditingController emailC;
  late TextEditingController passC;

  // Fungsi Remember Me dengan Get Storage

  @override
  void onInit() async {
    super.onInit();
    emailC = TextEditingController();
    passC = TextEditingController();
    final box = GetStorage();
    if (box.read("dataUser") != null) {
      final data = box.read("dataUser") as Map<String, dynamic>;
      emailC.text = data["email"];
      passC.text = data["password"];
      rememberMe.value = data["rememberMe"];
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
