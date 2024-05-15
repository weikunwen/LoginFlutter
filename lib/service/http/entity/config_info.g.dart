// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigInfo _$ConfigInfoFromJson(Map<String, dynamic> json) => ConfigInfo(
      json['id'] as String?,
      json['configKey'] as String?,
      json['configValue'] as String?,
      json['configDescribe'] as String?,
    );

Map<String, dynamic> _$ConfigInfoToJson(ConfigInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'configKey': instance.configKey,
      'configValue': instance.configValue,
      'configDescribe': instance.configDescribe,
    };
