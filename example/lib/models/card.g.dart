// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card(
    json['name'] as String,
  )..no = json['no'] as String?;
}

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'no': instance.no,
      'name': instance.name,
    };
