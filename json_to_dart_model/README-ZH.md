
语言: [English](https://github.com/yanguoyu/json_model/blob/master/json_to_dart_model/README.md) | [中文简体](https://github.com/yanguoyu/json_model/blob/master/json_to_dart_model/README-ZH.md)


# json_to_dart_model [![Pub](https://img.shields.io/pub/v/json_to_dart_model.svg?style=flat-square)](https://pub.dartlang.org/packages/json_to_dart_model)

只用一行命令，直接将Json文件转为Dart model类。

## 使用

1. 引入依赖
```yaml
dependencies:
  json_annotation: ^2.2.0

dev_dependencies:
  json_to_dart_model: latest
  build_runner: ^1.0.0
  json_serializable: ^2.2.0
```
2. 在 lib/model 中创建 json 文件;
3. 运行 `pub run build_runner build` (Dart VM工程)or `flutter packages pub run build_runner build`(Flutter中) 命令生成Dart model类，生成的文件与json在同一目录
4. 或者运行 `pub run build_runner watch` (Dart VM工程)or `flutter packages pub run build_runner watch`(Flutter中) 命令生成Dart model类，watch时会实时监控json文件的修改，实时生成.dart

## 例子

Json文件: `jsons/user.json`

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

生成的Dart model类:

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

### json 字段说明

1. @import 此类需要 import 的类，可以为一个或多个，当 value 为 String：默认为一个依赖；当 value 为 List：默认为多个依赖
2. @with 使用 with 关键词为 当前类扩展
3. @extends 使用 extends 关键词 为当前继承
4. 其余字段
  如果 value 为 String，则认为 value 为此字段的类型
  如果 value 为 Map，则 Map 里面 的 pre 为 json_serializable 支持的注解、type 为此字段的类型

### 说明
1. 本 lib 库仅根据 json 文件生成 .dart 文件，后续的生成 .g.dart 依赖 json_serializable 和 json_annotation，支持所有的json_serializable注解
2. 默认读取lib/model 中的json文件，如果需要读取其他目录下的文件，请单独设置 build.yml, 通过include 和 exclude 设置转换的目录
``` yaml
targets:
  $default:
    builders:
      json_to_dart_model|jsonBuilder:
        generate_for:
          include:
            - lib/test_build_yml/**

```