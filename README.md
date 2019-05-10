
Language: [English](README.md) | [中文简体](README-ZH.md)


# json_model [![Pub](https://img.shields.io/pub/v/json_model.svg?style=flat-square)](https://pub.dartlang.org/packages/json_model)

Gernerating Dart model class from Json file.

## Installing

```yaml
dev_dependencies:
  json_model: #latest version
```

## Getting Started

1. Create a "jsons" directory in the root of your project;
2. Create a Json file under "jsons" dir ;
3. Run `flutter packages pub run json_model` (in Flutter) or  `pub run json_model`  (in Dart VM)

## Examples

File: `jsons/user.json`

```json
{
  "name":"wendux",
  "father":"$user", //Other class model 
  "friends":"$[]user", // Array  
  "keywords":"$[]String", // Array
  "age":20
}
```

Run `pub run json_model`, then  you'll see the generated json file under  `lib/models/` dir:

```dart
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
    User();
    
    String name;
    User father;
    List<User> friends;
    List<String> keywords;
    num age;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}

```

### @JsonKey

You can also use “@JsonKey” annotation from [json_annotation](https://pub.dev/packages/json_annotation) package.

```json
{
  "@JsonKey(ignore: true) dynamic":"md",
  "@JsonKey(name: '+1') int": "loved",
  "name":"wendux",
  "age":20
}
```

The generated class is:

```dart
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    @JsonKey(ignore: true) dynamic md;
    @JsonKey(name: '+1') int loved;
    String name;
    num age;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

Test:

```dart
import 'models/index.dart';

void main() {
  var u = User.fromJson({"name": "Jack", "age": 16, "+1": 20});
  print(u.loved); // 20
}
```

### @Import 

```javascript
{
  "@import":"test_dir/profile.dart", //import file for model class
  "@JsonKey(ignore: true) Profile":"profile",
  "name":"wendux",
  "age":20
}
```

The generated class:

```dart
import 'package:json_annotation/json_annotation.dart';
import 'test_dir/profile.dart';  // import file
part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    @JsonKey(ignore: true) Profile profile; //file
    String name;
    num age;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

For completed examples see [here](https://github.com/flutterchina/json_model/tree/master/example) .

##  Command arguments

The default json source file directory is ` project_root/jsons`;  you can custom the src file directory by `src` argument, for example:

```shell
pub run json_model src=json_files 
```

You can also custom the dist directory by `dist` argument:

```shell
pub run json_model src=json_files  dist=data # will save in lib/data dir
```

> The `dist` root is `lib`

## Run by code

If you want to run json_model by code instead command line, you can:

```dart
import 'package:json_model/json_model.dart';
void main() {
  run(['src=jsons']);  //run
}
```

