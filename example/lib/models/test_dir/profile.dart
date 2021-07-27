import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  final String? name;
  final num? age;
  final bool? male;
  
  Profile({this.name, this.age, this.male});

  factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
