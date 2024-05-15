import 'package:common_utils/common_utils.dart';
import 'package:login_flutter/common/BasePage.dart';
import 'package:login_flutter/controller/login_controller.dart';
import 'package:login_flutter/enums/login_type.dart';
import 'package:login_flutter/utils/logger_util.dart';
import 'package:login_flutter/utils/toast_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  LoginPhoneState createState() => LoginPhoneState();
}

class LoginPhoneState extends State<LoginPhoneScreen> with WidgetsBindingObserver {
  final _loginController = Get.put(LoginController());
  final TextEditingController _phoneEditController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _phoneEditController.text = _loginController.loginPhone.value;
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _loginController.updateLoginType(_loginController.loginType.value);
    _loginController.updateLoginPhone(_loginController.loginPhone.value);
    super.deactivate();
  }

  @override
  void dispose() {
    logger.i("login_phone_screen: The dispose is invoked.");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
      _loginController.isShowLoginLogo.value = !(keyboardHeight > 0); //(keyboardHeight > 0)键盘弹出
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 设置状态栏透明
      statusBarIconBrightness: Brightness.light, // 设置状态栏图标为白色
    ));
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]); // 隐藏系统按键

    return OKToast(
      textStyle: const TextStyle(color: Colors.white,fontSize: 16.0),
      textPadding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
      position: ToastPosition.center,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset:false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: (MediaQuery.of(context).padding.top)),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const ImageIcon(
                        AssetImage('assets/images/arrow_bottom_white.png'),
                        color: Colors.white,
                        size: 24,
                      )),
                ),
                Obx(() => _loginController.isShowLoginLogo.value ? Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 50.0),
                  child: const Image(image: AssetImage('assets/images/login_logo.png'), width: 127.0, height: 50.0),
                ) : Container(height: 0.0)),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      Container(
                        margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Obx(() => TextField(
                          onChanged: (value) {
                            _loginController.loginPhone.value = value;
                            if (value.length == 11) {
                              _loginController.verifyCodeEnable.value = true;
                            } else {
                              _loginController.verifyCodeEnable.value = false;
                            }
                          },
                          controller: _phoneEditController,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white, fontSize: 15.0),
                          keyboardType: TextInputType.phone,
                          maxLength: 11,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(90, 90, 90, 1))),
                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            icon: ImageIcon(const AssetImage('assets/images/login_phone_unselected.png'), size:23, color: TextUtil.isEmpty(_loginController.loginPhone.value) ? Colors.grey : Colors.white,),
                            hintText: "手机号",
                            hintStyle: const TextStyle(color: Color.fromARGB(255, 185, 183, 186), fontSize: 15.0),
                          ),
                        ),),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => LoginType.mobile.value == _loginController.loginType.value ? Container(
                        margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(child: TextField(
                              onChanged: (value) {
                                _loginController.userPassword.value = value;
                              },
                              obscureText: true,
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white, fontSize: 15.0),
                              keyboardType: TextInputType.visiblePassword,
                              maxLength: 11,
                              decoration: InputDecoration(
                                counterText: "",
                                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(90, 90, 90, 1))),
                                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                icon: ImageIcon(const AssetImage('assets/images/login_pwd_unselected.png'), size:23, color: TextUtil.isEmpty(_loginController.userPassword.value) ? Colors.grey : Colors.white,),
                                hintText: "请输入密码",
                                hintStyle: const TextStyle(color: Color.fromARGB(255, 185, 183, 186), fontSize: 15.0),
                              ),
                            ),),
                            Container(
                              margin: const EdgeInsets.only(left: 15.0),
                              height: 20.0,
                              child: TextButton(onPressed: () { }, style: TextButton.styleFrom(padding: EdgeInsets.zero), child: const Text('忘记密码?',
                                  style: TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.underline, decorationColor: Colors.white))),
                            ),
                          ],
                        ),
                      ) : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => _getVerifyCodeInput()),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0, left: 56.0, right: 20.0),
                            child: const Text("未注册手机号验证通过后将自动登录", style: TextStyle(color: Color.fromARGB(255, 153, 153, 153), fontSize: 12.0)),
                          ),
                          const SizedBox(height: 35.0),
                          Container(
                            margin: const EdgeInsets.only(right: 20.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(color: Colors.white, fontSize: 15.0),
                                    children: <TextSpan> [
                                      const TextSpan(text: '收不到验证码?试试'),
                                      TextSpan(
                                          text: '语音验证码',
                                          style: const TextStyle(color: Color.fromARGB(255, 46, 164, 249)),
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                            print('查看更多被点击');
                                          }),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),),
                      Obx(() => Container(
                        height: 46,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: _loginController.loginType.value == LoginType.mobile.value ? 50.0 : 8.0, left: 20.0, right: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: (!TextUtil.isEmpty(_loginController.loginPhone.value) && !TextUtil.isEmpty(_loginController.userVerifyCode.value)) ? Colors.blue : const Color.fromARGB(255, 153, 153, 153),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.disabled)) {
                                return const Color.fromARGB(255, 153, 153, 153); // 不可点击时的背景颜色
                              }
                              return Colors.blue; // 可点击时的背景颜色
                            }),
                          ),
                          onPressed: getLoginBtnState() ? () {
                            // loginController.login(loginController.userPhone.value, loginController.userVerifyCode.value);
                            if (!_loginController.isAgreePrivacy.value) {
                              ToastUtil.toast("请勾选会员使用协议");
                              return;
                            }
                            FocusScope.of(context).unfocus(); // 点击空白处隐藏输入法
                            // _loginController.login(_loginController.loginPhone.value, LoginType.mobile.value == _loginController.loginType.value ?
                            //   _loginController.userPassword.value : _loginController.userVerifyCode.value, _loginController.loginType.value);
                          } : null,
                          child: const Text('登录', style: TextStyle(color: Colors.white, fontSize: 16.0),),
                        ),
                      ),),
                      Obx(() => Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(onPressed: () {
                              _loginController.loginType.value = _loginController.loginType.value == LoginType.mobile.value ? LoginType.mcode.value : LoginType.mobile.value;
                            }, style: TextButton.styleFrom(padding: EdgeInsets.zero), child: Text(_loginController.loginType.value == LoginType.mobile.value ? '验证码登录' : '手机密码登录', style: const TextStyle(color: Colors.white, fontSize: 14))),
                            TextButton(onPressed: () { }, style: TextButton.styleFrom(padding: EdgeInsets.zero), child: const Text('账号密码登录', style: TextStyle(color: Colors.white, fontSize: 14))),
                          ],
                        ),
                      ),)
                    ],
                  ),
                ),
                Expanded( // 第二个Align占据所有剩余的高度
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4.0),
                      child: PrivacyWidget(onChanged: (value) {
                        _loginController.isAgreePrivacy.value = value ?? false;
                      },),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    ),);
  }

  Widget _getVerifyCodeInput() {
    return _getVerifyCodeTextField(
      decoration: InputDecoration(
        counterText: "",
        icon: ImageIcon(const AssetImage('assets/images/login_reg_verify_code_unselected.png'), size: 20, color: TextUtil.isEmpty(_loginController.userVerifyCode.value) ? Colors.grey : Colors.white),
        border: InputBorder.none,
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(90, 90, 90, 1))),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: "请输入验证码",
        hintStyle: const TextStyle(color: Color.fromARGB(255, 185, 183, 186), fontSize: 15.0),
      ),
      //使用 onChanged 完成双向绑定
      onChanged: (value) {
        _loginController.userVerifyCode.value = value;
      },
      obscureText: true,
    );
  }

  Widget _getVerifyCodeTextField({
    TextEditingController? controller,
    InputDecoration? decoration,
    ValueChanged<String>? onChanged,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextField(
            maxLength: 6,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white, fontSize: 15.0),
            keyboardType: TextInputType.number,
            obscureText: obscureText,
            controller: controller,
            decoration: decoration,
            onChanged: onChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 1.0, // 设置竖线的宽度
                height: 25.0,
                color: const Color.fromRGBO(90, 90, 90, 1), // 设置竖线的颜色
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: _loginController.verifyCodeEnable.value ? const Text("获取验证码", style: TextStyle(color: Colors.white, fontSize: 15.0))
                      : const Text("获取验证码", style: TextStyle(color: Color.fromRGBO(90, 90, 90, 1), fontSize: 15.0)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool getLoginBtnState() {
    bool isPwdOrCodeNotEmpty = false;
    if (LoginType.mobile.value == _loginController.loginType.value) {
      isPwdOrCodeNotEmpty = !TextUtil.isEmpty(_loginController.userPassword.value);
    } else if (LoginType.mcode.value == _loginController.loginType.value) {
      isPwdOrCodeNotEmpty = !TextUtil.isEmpty(_loginController.userVerifyCode.value);
    }
    return isPwdOrCodeNotEmpty && !TextUtil.isEmpty(_loginController.loginPhone.value);
  }
}

//用户协议和隐私政策
class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({super.key, required this.onChanged});
  final ValueChanged<bool?> onChanged;

  @override
  PrivacyWidgetState createState() => PrivacyWidgetState();
}

class PrivacyWidgetState extends State<PrivacyWidget> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // 子元素水平居中对齐
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Checkbox(
              value: isChecked,
              activeColor: Colors.blue,  //选中时填充色
              checkColor: Colors.white, //选中时√颜色
              shape: const CircleBorder(side: BorderSide(color: Colors.white, width: 2.0)),
              // 设置为圆形
              onChanged: (value) {
                widget.onChanged(value);
                setState(() {
                  isChecked = value;
                });
              }),
        ),
        RichText(
          text: TextSpan(
              style: const TextStyle(color: Colors.white, fontSize: 14.0),
              children: <TextSpan>[
                const TextSpan(text: '登录即表示同意'),
                TextSpan(
                    text: '《E充站用户使用协议》',
                    style: const TextStyle(color: Color.fromARGB(255, 46, 164, 249), fontSize: 13),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      print("E充站用户使用协议");
                    }),
                const TextSpan(text: '和'),
                TextSpan(
                    text: '《隐私政策》',
                    style: const TextStyle(color: Color.fromARGB(255, 46, 164, 249), fontSize: 13),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // ToastUtil.toast(SpUtil.getInstance().get<String>('loginPhone') ?? '');
                        Get.dialog(
                          barrierDismissible: false, // 禁止点击外区销毁dialog
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }),
              ]),
        ),
      ],
    );
  }
}