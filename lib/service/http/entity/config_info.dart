
import 'package:json_annotation/json_annotation.dart';
part "config_info.g.dart";

@JsonSerializable()
class ConfigInfo {
  final String? id;
  final String? configKey;
  final String? configValue;
  final String? configDescribe;

  ConfigInfo(this.id, this.configKey, this.configValue, this.configDescribe);
  factory ConfigInfo.fromJson(Map<String, dynamic> json) => _$ConfigInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigInfoToJson(this);

}
