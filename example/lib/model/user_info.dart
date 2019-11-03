// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// JsonModel Builder
// **
import 'package:json_annotation/json_annotation.dart';
import 'card.dart';
import 'test_dir/profile.dart';
part 'user_info.g.dart';

@JsonSerializable()
class UserInfo  {
  UserInfo({
    this.profile,this.loved,this.name,this.father,this.friends,this.keywords,this.bankCards,this.age
  });

  @JsonKey(ignore: true)
  final Profile profile;

  @JsonKey(name: '+1')
  final int loved;

  final String name;

  final UserInfo father;

  final List<UserInfo> friends;

  final List<String> keywords;

  final List<Card> bankCards;

  final int age;


  factory UserInfo.fromJson(Map<String,dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}