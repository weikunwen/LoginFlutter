import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import '../../common/config.dart';
import 'entity/config_info.dart';

import 'entity/user_info.dart';

part "httpService.g.dart";

@RestApi(baseUrl: Constant.apiUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('configure/global')
  Future<EvResponse<List<ConfigInfo>>> getConfigInfo();

  @POST("my/user/login")
  Future<EvResponse<UserInfo>> login(@Body() Map<String,dynamic> body);
}

@JsonSerializable(genericArgumentFactories: true)
class EvResponse<T> {
  final code;
  final message;
  final data;

  EvResponse({this.code, this.message, this.data});

  factory EvResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$EvResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$EvResponseToJson(this, toJsonT);
}

