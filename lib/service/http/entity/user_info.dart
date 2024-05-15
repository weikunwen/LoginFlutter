
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class UserInfo {
   String userId = "";
   String? nickName;
   String? expiredTime;
   String token = "";
   int? bindMobile;
   String? regChannel;//注册渠道
   int? isBlock;//是否是黑名单用户
   String? regCity;//注册城市
   int? isInitPassword;//是否需要初始化密码
   int? isNewCreated;//是否新注册
   UserInfo();
   factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

   Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo()
   ..userId = json['userId'].toString()
   ..nickName = json['nickName'] as String?
   ..token = json['token'] as String
   ..isBlock = json['isBlock'] as int?
   ..expiredTime = json['expiredTime'] as String?
   ..bindMobile = json['bindMobile'] as int?
   ..regChannel = json['regChannel'] as String?
   ..regCity = json['regCity'] as String?
   ..isInitPassword = json['isInitPassword'] as int?
   ..isNewCreated = json['isNewCreated'] as int?;

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
   'userId': instance.userId,
   'nickName': instance.nickName,
   'expiredTime': instance.expiredTime,
   'token': instance.token,
   'bindMobile': instance.bindMobile,
   'regChannel': instance.regChannel,
   'isBlock': instance.isBlock,
   'regCity': instance.regCity,
   'isInitPassword': instance.isInitPassword,
   'isNewCreated': instance.isNewCreated,
};