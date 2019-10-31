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
  UserInfo();

  @JsonKey(ignore: true)
  Profile profile;

  @JsonKey(name: '+1')
  int loved;

  String name;

  UserInfo father;

  List<UserInfo> friends;

  List<String> keywords;

  List<Card> bankCards;

  int age;


  factory UserInfo.fromJson(Map<String,dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}