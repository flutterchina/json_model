import 'package:json_annotation/json_annotation.dart';
import 'test_dir/profile.dart';
import "card.dart";
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(ignore: true) Profile? profile;
  @JsonKey(name: '+1') int? loved;
  String name;
  User? father;
  List<User>? friends;
  List<String>? keywords;
  @JsonKey(name: 'bank_cards') List<Card>? bankCards;
  num? age;
  Plan? plan;
  List<Project>? project;
  
  User(this.name);

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Plan {
  String? name;
  num? space;
  @JsonKey(name: 'private_repos') num? privateRepos;
  num? collaborators;
  
  Plan();

  factory Plan.fromJson(Map<String,dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}

@JsonSerializable()
class Project {
  String? name;
  num? star;
  
  Project();

  factory Project.fromJson(Map<String,dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
