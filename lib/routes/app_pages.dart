import 'package:get/get.dart';
import '../pages/change_profile.dart';
import '../pages/profile.dart';
import 'route_name.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/details.dart';
import '../pages/testPage.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: RouteName.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteName.details,
      page: () => DetailsPage(),
    ),
    GetPage(
      name: RouteName.profile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: RouteName.changeProfile,
      page: () => const ChangeProfile(),
    ),
    GetPage(
      name: RouteName.testPage,
      page: () => const TestPage(),
    ),
  ];
}
