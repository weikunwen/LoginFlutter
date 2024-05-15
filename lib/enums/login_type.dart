enum LoginType {
  // 登录类型， mobile 手机号 + 密码、mcode手机号 + 验证码、origin 原始账户(默认mcode)
  mobile, mcode, origin
}

extension LoginTypeValue on LoginType {
  String get value {
    switch (this) {
      case LoginType.mobile:
        return "mobile";
      case LoginType.mcode:
        return "mcode";
      case LoginType.origin:
        return "origin";
    }
  }
}