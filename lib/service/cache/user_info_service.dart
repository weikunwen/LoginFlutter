import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:login_flutter/service/global_setting_service.dart';
import 'package:login_flutter/service/http/entity/user_info.dart';
import 'package:login_flutter/utils/sp_util.dart';
import 'package:get/get.dart';

/*
 * 用户登录成功信息本地缓存
 **/
class UserInfoService extends GetxService {
  static const String userInfoServiceTag = "userInfoServiceTag";
  static UserInfoService get serviceInstance => Get.find(tag: userInfoServiceTag);

  static const String keyUserInfo = 'userInfo';
  UserInfo _userInfo = UserInfo();

  UserInfo get userInfo {
    if (TextUtil.isEmpty(_userInfo.userId)) {
      String userJson = SpUtil.getInstance().get<String>(keyUserInfo) ?? "";
      Map<String, dynamic> userMap = <String, dynamic>{};
      if (!TextUtil.isEmpty(userJson)) {
        userMap = jsonDecode(userJson);
        _userInfo = UserInfo.fromJson(userMap);
      }
    }
    return _userInfo;
  }

  set userInfo(UserInfo userInfo) {
    _userInfo = userInfo;
    GlobalSettingService.serviceInstance.updateUserToken(userInfo.token);
    SpUtil.getInstance().setData(keyUserInfo, jsonEncode(userInfo.toJson()));
  }
}