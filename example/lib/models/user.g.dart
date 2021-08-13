// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String,
  )
    ..loved = json['+1'] as int?
    ..father = json['father'] == null
        ? null
        : User.fromJson(json['father'] as Map<String, dynamic>)
    ..friends = (json['friends'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList()
    ..keywords =
        (json['keywords'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..bankCards = (json['bank_cards'] as List<dynamic>?)
        ?.map((e) => Card.fromJson(e as Map<String, dynamic>))
        .toList()
    ..age = json['age'] as num?
    ..plan = json['plan'] == null
        ? null
        : Plan.fromJson(json['plan'] as Map<String, dynamic>)
    ..project = (json['project'] as List<dynamic>?)
        ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
        .toList()
    ..topics =
        (json['topics'] as List<dynamic>?)?.map((e) => e as String).toList()
    ..organization = json['organization'] == null
        ? null
        : Organization.fromJson(json['organization'] as Map<String, dynamic>)
    ..assignees = json['assignees'] as List<dynamic>?;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '+1': instance.loved,
      'name': instance.name,
      'father': instance.father,
      'friends': instance.friends,
      'keywords': instance.keywords,
      'bank_cards': instance.bankCards,
      'age': instance.age,
      'plan': instance.plan,
      'project': instance.project,
      'topics': instance.topics,
      'organization': instance.organization,
      'assignees': instance.assignees,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return Plan()
    ..name = json['name'] as String?
    ..space = json['space'] as num?
    ..privateRepos = json['private_repos'] as num?
    ..collaborators = json['collaborators'] as num?;
}

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'name': instance.name,
      'space': instance.space,
      'private_repos': instance.privateRepos,
      'collaborators': instance.collaborators,
    };

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project()
    ..name = json['name'] as String?
    ..star = json['star'] as num?;
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'name': instance.name,
      'star': instance.star,
    };

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return Organization()
    ..project = (json['project'] as List<dynamic>?)
        ?.map((e) => Project1.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'project': instance.project,
    };

Project1 _$Project1FromJson(Map<String, dynamic> json) {
  return Project1()
    ..name = json['name'] as String?
    ..owe = json['owe'] as String?;
}

Map<String, dynamic> _$Project1ToJson(Project1 instance) => <String, dynamic>{
      'name': instance.name,
      'owe': instance.owe,
    };
