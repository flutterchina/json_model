import 'package:json_annotation/json_annotation.dart';
import 'test_dir/profile.dart';
import "card.dart";
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(ignore: true) final Profile? profile;
  @JsonKey(name: '+1') final int? loved;
  final String name;
  final User? father;
  final List<User>? friends;
  final List<String>? keywords;
  final List<Card>? bankCards;
  final num? age;
  
  User({this.profile, this.loved, required this.name, this.father, this.friends, this.keywords, this.bankCards, this.age});

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
