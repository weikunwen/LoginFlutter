import 'package:get/get.dart';
import 'package:login_flutter/screen/login/login_phone_screen.dart';

class AppPage {
  static final routes = [
    GetPage(name: '/login_phone', page: () => const LoginPhoneScreen()),
  ];
}