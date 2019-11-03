// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
      age: json['age'] as int,
      firstName: json['first_name'] as String,
      secondName: json['secondName'] as String,
      listInt: (json['listInt'] as List)?.map((e) => e as int)?.toList(),
      listStr: (json['listStr'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'age': instance.age,
      'first_name': instance.firstName,
      'secondName': instance.secondName,
      'listInt': instance.listInt,
      'listStr': instance.listStr
    };
