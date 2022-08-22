import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newbookapp/controllers/controller.dart';
import 'package:newbookapp/pages/login.dart';

import '../data/global.dart';
import '../data/widgets/sign_up_check.dart';

class RegisterPage extends StatelessWidget {
  final c = Get.find<AuthController>();
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
                    "Daftarkan Akun Anda",
                    style: GoogleFonts.montserrat(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Get.height * 0.03),
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
                  ),
                  SizedBox(height: Get.height * 0.03),

                  GestureDetector(
                    onTap: () {
                      c.register(c.emailC.text.trim(), c.passC.text.trim());
                    },
                    child: Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.5,
                      decoration: BoxDecoration(
                        color: color1, borderRadius: BorderRadius.circular(30),
                        // gradient: LinearGradient(
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        //   colors: [color1, color2],
                        // ),
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
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
                    login: false,
                    press: () => Get.off(() => LoginPage()),
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
                  // Or Divider
                  // Container(
                  //   margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                  //   width: Get.width * 0.8,
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Divider(
                  //           height: 1.5,
                  //           color: Color(0xFFD9D9D9),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: Text(
                  //           "OR",
                  //           style: TextStyle(
                  //             color: color1,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Divider(
                  //           height: 1.5,
                  //           color: Color(0xFFD9D9D9),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {},
                  //       child: Container(
                  //         margin: EdgeInsets.symmetric(horizontal: 10),
                  //         padding: EdgeInsets.all(20),
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             width: 2,
                  //             color: kPrimaryLightColor,
                  //           ),
                  //           shape: BoxShape.circle,
                  //         ),
                  //         child: SvgPicture.asset(
                  //           "assets/icons/google-plus.svg",
                  //           height: 20,
                  //           width: 20,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
