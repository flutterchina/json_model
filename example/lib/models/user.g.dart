// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..loved = json['+1'] as int
    ..name = json['name'] as String
    ..father = json['father'] == null
        ? null
        : User.fromJson(json['father'] as Map<String, dynamic>)
    ..friends = (json['friends'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..keywords = (json['keywords'] as List)?.map((e) => e as String)?.toList()
    ..bankCards = (json['bankCards'] as List)
        ?.map(
            (e) => e == null ? null : Card.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..age = json['age'] as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '+1': instance.loved,
      'name': instance.name,
      'father': instance.father,
      'friends': instance.friends,
      'keywords': instance.keywords,
      'bankCards': instance.bankCards,
      'age': instance.age
    };
