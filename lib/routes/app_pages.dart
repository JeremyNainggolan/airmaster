// ignore_for_file: constant_identifier_names

import 'package:airmaster/routes/app_routes.dart';
import 'package:airmaster/screens/auth/login.dart';
import 'package:airmaster/screens/home/dashboard.dart';
import 'package:airmaster/screens/home/ts_1/home/view/ts1_home.dart';
import 'package:airmaster/screens/home/ts_1/main/ts1_view.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.MAIN_SCREEN, page: () => const HomeView()),
    GetPage(name: AppRoutes.LOGIN_SCREEN, page: () => const LoginView()),
    GetPage(name: AppRoutes.TS1_MAIN, page: () => const TS1View()),
    GetPage(name: AppRoutes.TS1_HOME_SCREEN, page: () => const TS1_Home()),
    // GetPage(name: AppRoutes.TC_HOME, page: () => const TCView()),
  ];
}
