
语言: [English](README.md) | [中文简体](README-ZH.md)


# json_model [![Pub](https://img.shields.io/pub/v/json_model.svg?style=flat-square)](https://pub.dartlang.org/packages/json_model)

只用一行命令，直接将Json文件转为Dart model类。

## 安装

```yaml
dev_dependencies: 
  json_model: #最新版本
```

## Getting Started

1. 在工程根目录下创建一个名为 "jsons" 的目录;
2. 创建或拷贝Json文件到"jsons" 目录中 ;
3. 运行 `pub run json_model` (Dart VM工程)or `flutter packages pub run json_model`(Flutter中) 命令生成Dart model类，生成的文件默认在"lib/models"目录下

## 例子

Json文件: `jsons/user.json`

```javascript
{
  "name":"wendux",
  "father":"$user", //可以通过"$"符号引用其它model类
  "friends":"$[]user", // 可以通过"$[]"来引用数组
  "keywords":"$[]String", // 同上
  "age":20
}
```

生成的Dart model类:

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

您也可以使用[json_annotation](https://pub.dev/packages/json_annotation)包中的“@JsonKey”标注特定的字段。

这个功能在特定场景下非常有用，比如Json文件中有一个字段名为"+1"，由于在转成Dart类后，字段名会被当做变量名，但是在Dart中变量名不能包含“+”，我们可以通过“@JsonKey”来映射变量名；

```javascript
{
  "@JsonKey(ignore: true) dynamic":"md",
  "@JsonKey(name: '+1') int": "loved", //将“+1”映射为“loved”
  "name":"wendux",
  "age":20
}
```

生成文件如下:

```dart
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
    User();
    @JsonKey(name: '+1') int loved;
    String name;
    num age;
    
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

### @Import 

另外，提供了一个`@Import `指令，该指令可以在生成的Dart类中导入指定的文件：

```json
{
  "@import":"test_dir/profile.dart",
  "@JsonKey(ignore: true) Profile":"profile",
  "name":"wendux",
  "age":20
}
```

生成的Dart类:

```dart
import 'package:json_annotation/json_annotation.dart';
import 'test_dir/profile.dart';  // 指令生效
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

更完整的示例请移步[这里](https://github.com/flutterchina/json_model/tree/master/example) .

##  命令参数

默认的源json文件目录为根目录下名为 "json" 的目录；可以通过 `src` 参数自定义源json文件目录，例如:

```shell
pub run json_model src=json_files 
```

默认的生成目录为"lib/models"，同样也可以通过`dist` 参数来自定义输出目录:

```shell
pub run json_model src=json_files  dist=data # 输出目录为 lib/data
```

> 注意，dist会默认已lib为根目录。

## 代码调用

如果您正在开发一个工具，想在代码中使用json_model，此时便不能通过命令行来调用json_model，这是你可以通过代码调用：

```dart
import 'package:json_model/json_model.dart';
void main() {
  run(['src=jsons']);  //run方法为json_model暴露的方法；
}
```

