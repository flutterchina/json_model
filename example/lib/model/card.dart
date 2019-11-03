// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// JsonModel Builder
// **
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class Card  {
  Card({
    this.no,this.name,this.hahha
  });

  final int no;

  final String name;

  final String hahha;


  factory Card.fromJson(Map<String,dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}