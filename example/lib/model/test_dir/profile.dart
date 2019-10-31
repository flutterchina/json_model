// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// JsonModel Builder
// **
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile  {
  Profile();

  String name;

  int age;

  bool male;


  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}