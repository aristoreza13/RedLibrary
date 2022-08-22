import 'package:firebase_core/firebase_core.dart';
import 'package:newbookapp/controllers/controller.dart';
import 'package:newbookapp/data/global.dart';
import 'package:newbookapp/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: color1),
      home: LoginPage(),
      getPages: AppPage.pages,
    );
  }
}

// class MyApp extends StatelessWidget {
//   final c = Get.put(Controller());
//   final loginC = Get.put(LoginC());
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: c.autoLogin(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Obx(
//             () => GetMaterialApp(
//               theme: ThemeData(primaryColor: color1),
//               home: c.isAuth.isTrue ? HomePage() : LoginPage(),
//               getPages: AppPage.pages,
//             ),
//           );
//         }
//         return MaterialApp(
//           home: Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

