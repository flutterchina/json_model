import 'package:json_annotation/json_annotation.dart';

part 'card.g.dart';

@JsonSerializable()
class Card {
    Card();

    String no;
    String name;
    
    factory Card.fromJson(Map<String,dynamic> json) => _$CardFromJson(json);
    Map<String, dynamic> toJson() => _$CardToJson(this);
}
