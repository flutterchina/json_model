
语言: [English](README.md) | [中文简体](README-ZH.md)


# json_model [![Pub](https://img.shields.io/pub/v/json_model.svg?style=flat-square)](https://pub.dartlang.org/packages/json_model)

一行命令，将Json文件转为Dart model类。

## 安装

```yaml
dev_dependencies: 
  json_model: ^1.0.0
  json_serializable: ^5.0.0
```

## 使用

1. 在工程根目录下创建一个名为 "jsons" 的目录;
2. 创建或拷贝Json文件到"jsons" 目录中 ;
3. 运行 `pub run json_model` (Dart VM工程)or `flutter packages pub run json_model`(Flutter中) 命令生成Dart model类，生成的文件默认在"lib/models"目录下

## 思想

大多数开发者可能都是通过UI工具来将Json文件来生成Dart model类。这会有一个小问题，一旦生成Dart model类后，原始的json数据是不会维护的，但现实开发中偶尔会有查看原始Json数据的需求。json_model的主要思路就是项目中**只维护json文件，而不用去关注生成的dart文件，只要json文件在，随时都可以通过一句命令生成dart类**。

json_model还有一个优势是在多人协作的项目中，可以集成到构建流程中，无需每个人都去安装一个转换工具。

当然，这只是一个小差异，如果你更喜欢UI工具的方式，按照自己喜欢的方式来就行。

## 例子

Json文件: `jsons/user.json`

```javascript
{
  "name":"wendux",
  "father":"$user", //可以通过"$"符号引用其它model类, 这个是引用User类
  "friends":"$[]user", // 可以通过"$[]"来引用数组
  "keywords":"$[]String", // 同上
  "age?":20  // 年龄，可能为null
}
```

生成的Dart model类:

```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  late String name;
  late User father;
  late List<User> friends;
  late List<String> keywords;
  num? age;
  
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Json标注

您也可以使用[json_annotation](https://pub.dev/packages/json_annotation)包中定义的所有标注。

比如Json文件中有一个字段名为"+1"，由于在转成Dart类后，字段名会被当做变量名，但是在Dart中变量名不能包含“+”，我们可以通过“@JsonKey”来映射变量名；

```javascript
{
  "@JsonKey(name: '+1') int?": "loved", //将“+1”映射为“loved”
  "name":"wendux",
  "age?":20
}
```

生成文件如下:

```dart
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User();
  @JsonKey(name: '+1') int? loved;
  late String name;
  num? age;
    
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

测试:

```dart
import 'models/index.dart';

void main() {
  var u = User.fromJson({"name": "Jack", "age": 16, "+1": 20});
  print(u.loved); // 20
}
```

> 关于 `@JsonKey`标注的详细内容请参考[json_annotation](https://pub.dev/packages/json_annotation) 包；



### $meta 配置

另外，在json文件中我们可以通过指定`$meta` 信息来定制生成Dart文件的规则：

```javascript
"@meta": {
  "import": [ // 生成的Dart文件中需要额外import的文件，可以有多个
    "test_dir/profile.dart"
  ],
  "comments": { // Json文件中相应字段的注释
    "name": "名字"
  },
  "nullable": true, // 是否生成的model字段都是可空的，如果为false，则字段为late
  "ignore": false // json->dart时是否跳过当前文件，默认为false，设为true时，生成时则会跳过本json文件
}
```

> `ignore` 配置在“需要手动修改自动生成的代码”的场景下非常实用。比如在首次生成之后dart文件后，如果我们需要添加一些逻辑，比如给model类添加了一个方法，如果后续再运行自动生成命令，则我们修改的类会被重新生成的代码覆盖掉，解决这个问题的方式就是修改后将ignore置为true，这样重新执行自动生成时会跳过该json文件。

例子:

user.json

```dart
{
  "@meta": {
    "import": [
      "test_dir/profile.dart"
    ],
    "comments": {
      "name": "名字"
    },
    "nullable": true
  },
  "@JsonKey(ignore: true) Profile?": "profile",
  "@JsonKey(name: '+1') int?": "loved",
  "name": "wendux",
  "father": "$user",
  "friends": "$[]user",
  "keywords": "$[]String",
  "age?": 20
}
```

生成文件如下:

```dart
import 'package:json_annotation/json_annotation.dart';
import 'test_dir/profile.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  @JsonKey(ignore: true) Profile? profile;
  @JsonKey(name: '+1') int? loved;
  //名字
  String? name;
  User? father;
  List<User>? friends;
  List<String>? keywords;
  num? age;
  
  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```



##  全局命令参数

默认的源json文件目录为根目录下名为 "json" 的目录；可以通过 `src` 参数自定义源json文件目录，例如:

```shell
pub run json_model src=json_files 
```

默认的生成目录为"lib/models"，同样也可以通过`dist` 参数来自定义输出目录:

```shell
pub run json_model src=json_files  dist=data # 输出目录为 lib/data
```

> 注意，dist会默认已lib为根目录。

默认的生成的字段都不是可空类型，我们可以通过设置--nullable参数来切换生成的类型为可空类型:

```shell
pub run json_model --nullable
```

> 注意：当json文件中的@meta中配置了nullable后会覆盖全局命令配置，也就是说json文件中的配置优先生效。

## 代码调用

如果您正在开发一个工具，想在代码中使用json_model，此时便不能通过命令行来调用json_model，这是你可以通过代码调用：

```dart
import 'package:json_model/json_model.dart';
void main() {
  run(['src=jsons']);  //run方法为json_model暴露的方法；
}
```

