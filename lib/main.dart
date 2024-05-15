import 'package:login_flutter/common/BasePage.dart';
import 'package:login_flutter/service/cache/user_info_service.dart';
import 'package:login_flutter/service/ev_api_service.dart';
import 'package:login_flutter/service/global_setting_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState()  => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          onInit: () {
            Get.put(GlobalSettingService(),tag: GlobalSettingService.globalServiceTag);
            Get.put(EvApiService(),tag: 'http_client');
            Get.put(UserInfoService(), tag: UserInfoService.userInfoServiceTag);
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            useMaterial3: true,
          ),
          // initialBinding: AllControllerBinding(),
          // home: const SplashScreen(),
          initialRoute: '/login_phone',
          getPages: AppPage.routes,
          // navigatorObservers: [BluetoothAdapterStateObserver()],
        )
    );
  }
}

