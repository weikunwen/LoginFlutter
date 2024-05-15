import 'package:common_utils/common_utils.dart';
import 'package:oktoast/oktoast.dart';

class ToastUtil {
  static void toast(String? msg) {
    if (TextUtil.isEmpty(msg)) {
      return;
    }
    showToast(msg!);
  }
}