import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class Card {
  final String? no;
  final String name;
  
  Card({this.no, required this.name});

  factory Card.fromJson(Map<String,dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
