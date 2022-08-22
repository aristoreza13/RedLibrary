import 'package:newbookapp/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:newbookapp/pages/register.dart';
import '../data/global.dart';
import '../data/widgets/sign_up_check.dart';

class LoginPage extends StatelessWidget {
  final c = Get.put(AuthController());
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
                    "Welcome to",
                    style: GoogleFonts.montserrat(
                        fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Red.",
                      style: TextStyle(color: color1, fontSize: 45),
                    ),
                    const TextSpan(
                      text: "Library",
                      style: TextStyle(color: Colors.black, fontSize: 45),
                    )
                  ])),
                  SizedBox(height: Get.height * 0.03),
                  Text(
                    "Login ke dalam akunmu",
                    style: GoogleFonts.montserrat(
                        fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  // Email Field
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: c.emailC,
                      autocorrect: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        suffixIcon: const Icon(Icons.backspace),
                        hintText: 'Masukkan Email',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  // Password Field
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Obx(
                      () => TextField(
                        controller: c.passC,
                        autocorrect: true,
                        obscureText: c.hidden.value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => c.hidden.toggle(),
                            icon: c.hidden.isTrue
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.remove_red_eye_outlined),
                          ),
                          hintText: 'Masukkan Password',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Obx(
                    () => CheckboxListTile(
                      value: c.rememberMe.value,
                      onChanged: (value) => c.rememberMe.toggle(),
                      title: const Text("Remember Me"),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      c.signIn(c.emailC.text.trim(), c.passC.text.trim());
                      // c.login(c.emailC.text.trim(), c.passC.text.trim());
                    },
                    // => c.login(loginC.emailC.text, loginC.passC.text,
                    //     loginC.rememberMe.value),
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.5,
                      decoration: BoxDecoration(
                        color: color1,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  SignUpCheck(
                    login: true,
                    press: () => Get.off(() => RegisterPage()),
                    // {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) {
                    //         return LoginScreen();
                    //       },
                    //     ),
                    //   );
                    // },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
