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
  List<String>? topics;
  Organization? organization;
  List<dynamic>? assignees;
  
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

@JsonSerializable()
class Organization {
  List<Project1>? project;
  
  Organization();

  factory Organization.fromJson(Map<String,dynamic> json) => _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable()
class Project1 {
  String? name;
  String? owe;
  
  Project1();

  factory Project1.fromJson(Map<String,dynamic> json) => _$Project1FromJson(json);

  Map<String, dynamic> toJson() => _$Project1ToJson(this);
}
