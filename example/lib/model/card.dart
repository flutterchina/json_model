// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// JsonModel Builder
// **
import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class Card  {
  Card();

  int no;

  String name;

  String hahha;


  factory Card.fromJson(Map<String,dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}