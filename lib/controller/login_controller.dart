import 'package:login_flutter/common/BasePage.dart';
import 'package:login_flutter/enums/login_type.dart';
import 'package:login_flutter/service/cache/user_info_service.dart';
import 'package:login_flutter/service/http/entity/user_info.dart';
import 'package:login_flutter/utils/logger_util.dart';
import 'package:login_flutter/utils/sp_util.dart';
import '../service/ev_api_service.dart';

/* 登录页面controller
* */
class LoginController extends GetxController {

  static const String keyLoginType = 'loginType';
  static const String keyLoginPhone = 'loginPhone';
  RxString userVerifyCode = ''.obs;
  RxString userPassword = ''.obs;
  RxBool isShowLoginLogo = true.obs;
  RxBool verifyCodeEnable = false.obs;

  RxString loginType = LoginType.mcode.value.obs;  //默认手机验证码
  RxString loginPhone = ''.obs;  //用户登录缓存的手机号
  RxBool isAgreePrivacy = false.obs;

  @override
  void onInit() async {
    super.onInit();
    getLoginType();
    getLoginPhone();
  }

  void login(String loginPhone, String pwd, String loginType) async {
    var paras = <String, dynamic>{};
    paras["loginId"] = loginPhone;
    paras["password"] = pwd;
    paras["loginType"] = loginType;
    EvApiService httpClient = Get.find(tag: 'http_client');
    httpClient.evRestClient.login(paras).then((resp) {
      if (resp.code == 200) {
        UserInfo userInfo = UserInfo.fromJson(resp.data);
        showToast('登录成功，token:${userInfo.token}');
        UserInfoService.serviceInstance.userInfo = userInfo;
      } else {
        showToast('登录失败:${resp.message}');
      }
    });
  }

  void agreePrivacy(Function(bool) callback) async {

  }

  void updateLoginType(String type) async {
    logger.i("The loginType is: $type");
    SpUtil.getInstance().setData(keyLoginType, type);
  }

  void updateLoginPhone(String phone) async {
    SpUtil.getInstance().setData(keyLoginPhone, phone);
  }

  void getLoginType() {
    loginType.value = SpUtil.getInstance().get<String>(keyLoginType) ?? LoginType.mcode.value;
  }

  void getLoginPhone() {
    loginPhone.value = SpUtil.getInstance().get<String>(keyLoginPhone) ?? '';
  }
}