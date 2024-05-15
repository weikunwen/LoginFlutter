
import 'dart:developer' as developer;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:login_flutter/service/cache/user_info_service.dart';
import 'package:login_flutter/utils/sp_util.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../common/config.dart';

/*全局数据信息获取、
* 包括设备信息
* 隐私政策读取标识
* 用户登录token
* 用户登录成功信息
* */
class GlobalSettingService extends GetxService {
  static const String globalServiceTag = "globalServiceTag";
  static GlobalSettingService get serviceInstance => Get.find(tag: globalServiceTag);  //全局变量表示GlobalSettingService单例

  static const String keyUuid = 'uuid';
  static const String keyToken = 'token';
  static const String keyPrivacy = 'privacy';

  var deviceID =''.obs;   //uuid
  var platType =''.obs;   //android or iOS
  var platInfo =''.obs;  //Build.MANUFACTURER + "_" + Build.MODEL + "|" + Build.VERSION.RELEASE);
  var privacyFlag = false.obs;  //隐私政策标识
  var userToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initGlobalInfo();
  }

  void initGlobalInfo() async {
    await SpUtil.preInit();
    _getDeviceID();
    _getPlatType();
    _initUserToken();
    _initPrivacyFlag();
  }

  void updateUserToken(String token) {
    userToken.value = token;
  }

  void updatePrivacyFlag(bool flag) {
    privacyFlag.value = flag;
    SpUtil.getInstance().setData(keyPrivacy, flag);
  }

  void _initUserToken() {
    userToken.value = UserInfoService.serviceInstance.userInfo.token;
  }

  void _initPrivacyFlag() {
    privacyFlag.value = SpUtil.getInstance().get<bool>(keyPrivacy) ?? false;
  }

  void _getDeviceID() async {
    var uuid = SpUtil.getInstance().get<String>(keyUuid)?? '';
    if(uuid.isEmpty) {
      uuid = const Uuid().v7();
      developer.log('--------------uuid is empty, get new  uuid:$uuid');
      SpUtil.getInstance().setData(keyUuid, uuid);
    }
    developer.log('-------------- get uuid:$uuid');
    deviceID.value = uuid;
  }

  void _getPlatType() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        platType.value = Constant.platAndroid;
        var info = await deviceInfoPlugin.androidInfo;
        platInfo.value  = '${info.manufacturer}_${info.model}_${info.version.release}' ;
        break;
      case TargetPlatform.iOS:
        platType.value = Constant.platIOS;
        var info = await deviceInfoPlugin.iosInfo;
        platInfo.value  = '${info.utsname.machine}_${info.model}_${info.utsname.release}';
        break;
      default:
    }
    developer.log('----------platType:$platType,platInfo:$platInfo');
  }
}