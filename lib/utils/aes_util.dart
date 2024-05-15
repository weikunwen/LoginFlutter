import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

String _key = '\$*@AB%DHJqopENC#';

Uint8List intToUint8List(int value) {
  // 将整数转换为字节序列
  var bytes = ByteData(4);
  bytes.setInt32(0, value); // 使用大端序
  return bytes.buffer.asUint8List();
}

Uint8List aesStringEncrypt(
  String planText,
) {
  final key = Key.fromUtf8(_key);
  final iv = IV.fromUtf8(_key);
  return Encrypter(AES(key, mode: AESMode.cbc)).encrypt(planText, iv: iv).bytes;
}

Uint8List aesByteEncrypt(List<int> input) {
  final key = Key.fromUtf8(_key);
  final iv = IV.fromUtf8(_key);
  return Encrypter(AES(key, mode: AESMode.cbc))
      .encryptBytes(input, iv: iv)
      .bytes;
}


List<int> aesByteDecrypt(Uint8List data)  {
  return Encrypter(AES(Key.fromUtf8(_key), mode: AESMode.cbc))
      .decryptBytes(Encrypted(data),iv: IV.fromUtf8(_key));
}
/**
 * 将16进制字符串转换为整型数组
 * */
List<int> hexStr2Bytes(String hexStr) {
  final bytes = <int>[];
  for (var i = 0; i < hexStr.length; i += 2) {
    bytes.add(int.parse(hexStr.substring(i, i + 2), radix: 16) & 0xFF);
  }
  return bytes;
}

/**
 *将byte数组按16进制格式输出
 */
String byte2HexStr(List<int> arr) {
  return arr.map((e) => e.toRadixString(16).padLeft(2, '0')).join(' ');
}

/**
 *将byte数组按16进制大写无空格格式输出
 */
String byte2UpperHexStr(List<int> arr) {
  return arr.map((e) => e.toRadixString(16).toUpperCase().padLeft(2, '0')).join();
}

Uint8List intToByteArray(int value) {
  // 分别获取整数的高低8位
  var low = value & 0xFF;
  var high = (value >> 8) & 0xFF;
  var high2 = (value >> 16) & 0xFF;
  var high3 = (value >> 24) & 0xFF;

  // 将四个字节组成Uint8List
  return Uint8List.fromList([high3, high2, high, low]);
}
/**
 *将byte数组输出为整型数据
 */
int  byteArrayToInt(List<int> byteArray) {
   int intValue= 0;
   for(int i = 0;i<byteArray.length; i++) {
     intValue =
     intValue | ((byteArray[i] & 0xFF) << 8 * (byteArray.length - 1 - i));
   }

   return intValue;
}