
Language: [English](README.md) | [中文简体](README-ZH.md)


# json_to_dart_model [![Pub](https://img.shields.io/pub/v/json_to_dart_model.svg?style=flat-square)](https://pub.dartlang.org/packages/json_to_dart_model)

Gernerating Dart model class from Json file.

## Getting Started

1. import dependencies
```yaml
dependencies:
  json_annotation: ^2.2.0

dev_dependencies:
  build_runner: ^1.0.0
  json_serializable: ^2.2.0
  json_to_dart_model: latest
```
2. create json files in lib/model
3. run
  1. run `pub run build_runner build` (Dart VM project) or `flutter packages pub run build_runner build`(Flutter), create files once
  2. run `pub run build_runner watch` (Dart VM project) or `flutter packages pub run build_runner watch`(Flutter中) watch and create files when json files changed

## Examples

File: `jsons/user.json`

```javascript
{
  "@import": ["card.dart", "test_dir/profile.dart"],
  "profile": {
    "pre": "@JsonKey(ignore: true)",
    "type": "Profile"
  },
  "loved": {
    "pre": "@JsonKey(name: '+1')",
    "type": "int"
  },
  "name": "String",
  "father": "UserInfo",
  "friends": "List<UserInfo>",
  "keywords": "List<String>",
  "bankCards": "List<Card>",
  "age": "int"
}
```

Run `pub run build_runner build`, then  you'll see the generated json file.

```dart
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

```

### Json Fields Description

1. @import Classes that need to be imported, this value support String or List.
2. @with Use the with keyword to expand the current class
3. @extends Use the extends keyword for current inheritance
4. other fileds
  value's type is String，value is the field's type
  value's type is Map，value["pre"] is json_serializable's annotations、value["type"] is current field's type

### Others Description
1. This lib library only generates .dart files from json files, Support for all json_serializable annotations
2. By default, the json file in lib/model will exchange. If you need to exchange the files in other directories,
  set build.yml, and set the converted directory by include and exclude.
``` yaml
targets:
  $default:
    builders:
      json_to_dart_model|jsonBuilder:
        generate_for:
          include:
            - lib/test_build_yml/**

```

