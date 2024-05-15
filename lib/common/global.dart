import 'package:flutter/cupertino.dart';

class Global {
  static MediaQueryData mediaQueryData = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first);
  // 屏幕宽度
  static double screenWidth = mediaQueryData.size.width;
  // 屏幕高度
  static double screenHeight = mediaQueryData.size.height;
  // 顶部安全区高度
  static double paddingTop = mediaQueryData.padding.top;
  // 底部安全区高度
  static double paddingBottom = mediaQueryData.padding.bottom;

  static Color mainBlueColor = const Color(0xFF54a3f2);
  static Color mainTitleColor = const Color(0xFF333333);
  static Color normalTitleColor = const Color(0xFF666666);
  static Color weakTitleColor = const Color(0xFF999999);
  static Color mainOrangeColor = const Color(0xFFff8926);


  static String unit = '点';
  static String unitPrice = '点/度';
}
