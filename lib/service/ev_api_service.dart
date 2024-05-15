

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'http/httpService.dart';
import 'global_setting_service.dart';

class EvApiService extends GetxService{
  late RestClient _api;

  get evRestClient => _api;

  @override
  void onInit() {
    super.onInit();
    _api = RestClient(_createDio());
  }

  Dio _createDio() {
    final dio = Dio(); // Provide a dio instance
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);

    dio.interceptors.add(DeviceInfoInterceptor());
    dio.interceptors.add(SignatureInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(
          LogInterceptor(request: true, requestBody: true, responseBody: true));
    }

    return dio;
  }
}

//设备信息设置拦截器
class DeviceInfoInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final GlobalSettingService deviceInfoController = GlobalSettingService.serviceInstance;
    options.headers['USER_DEVICE_ID'] = deviceInfoController.deviceID.value;
    options.headers['APP_VER'] = '4.0.0';
    options.headers['PLAT_TYPE'] = deviceInfoController.platType.value;
    options.headers['PLAT_INFO'] = deviceInfoController.platInfo.value;
    options.headers['USER_TOKEN'] = deviceInfoController.userToken.value;
//todo: 添加定位信息
// dio.options.headers['LAT'] = 'lat';
// dio.options.headers['LNG'] = 'lng';
// dio.options.headers['CITY_CODE'] = 'code';
    handler.next(options);
  }
}

//签名信息拦截器
class SignatureInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // super.onRequest(options, handler);
    final GlobalSettingService deviceInfoController = GlobalSettingService.serviceInstance;
    int timeStamp =
        DateTime.now().microsecondsSinceEpoch; //todo :还需补充计算本机时间与服务器时间的差值
    options.headers['EV_TS'] = timeStamp.toString();

    var uri = Uri.parse(options.baseUrl);
    var path = uri.path;
    String deviceId = deviceInfoController.deviceID.value;
    String platType = deviceInfoController.platType.value;
    String url =
        '$path#/timestamp=$timeStamp&deviceId=$deviceId&platType=$platType&signVer=0.0.1/evappsign';
    options.headers['EV_SIGN'] = sha_1(url); //签名信息
    handler.next(options);
  }

  String sha_1(String content) {
    var contentBytes = utf8.encode(content);
    var digest = sha1.convert(contentBytes);
    return digest.toString();
  }
}