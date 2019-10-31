// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..loved = json['+1'] as int
    ..name = json['name'] as String
    ..father = json['father'] == null
        ? null
        : UserInfo.fromJson(json['father'] as Map<String, dynamic>)
    ..friends = (json['friends'] as List)
        ?.map((e) =>
            e == null ? null : UserInfo.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..keywords = (json['keywords'] as List)?.map((e) => e as String)?.toList()
    ..bankCards = (json['bankCards'] as List)
        ?.map(
            (e) => e == null ? null : Card.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..age = json['age'] as int;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      '+1': instance.loved,
      'name': instance.name,
      'father': instance.father,
      'friends': instance.friends,
      'keywords': instance.keywords,
      'bankCards': instance.bankCards,
      'age': instance.age
    };
