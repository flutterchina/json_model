import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:build_runner_core/build_runner_core.dart';
import 'package:path/path.dart' as path;
import 'build_runner.dart' as br;

const tplTop = "import 'package:json_annotation/json_annotation.dart';\n%t\npart '%s.g.dart';\n";
const tpl =
    "\n@JsonSerializable()\nclass %s {\n  %s\n  %s(%s);\n\n  factory %s.fromJson(Map<String,dynamic> json) => _\$%sFromJson(json);\n\n  Map<String, dynamic> toJson() => _\$%sToJson(this);\n}\n";

void main(List<String> args) {
  String src;
  String dist;
  String tag;
  bool fixed;
  var parser = new ArgParser();
  parser.addOption('src', defaultsTo: './jsons', callback: (v) => src = v, help: "Specify the json directory.");
  parser.addOption('dist', defaultsTo: 'lib/models', callback: (v) => dist = v, help: "Specify the dist directory.");
  parser.addOption('tag', defaultsTo: '\$', callback: (v) => tag = v, help: "Specify the tag ");
  parser.addOption('fix', defaultsTo: '0', callback: (v) => fixed = ('0' != v), help: "Specify the fixed ");
  parser.parse(args);
  print(args);
  if (walk(src, dist, tag, fixed)) {
    //br.run(['clean']);
    PackageGraph.forThisPackage().then((value) => br.run(['build', '--delete-conflicting-outputs'], value));
  }
}

//遍历JSON目录生成模板
bool walk(String srcDir, String distDir, String tag, bool fixed) {
  if (srcDir.endsWith("/")) srcDir = srcDir.substring(0, srcDir.length - 1);
  if (distDir.endsWith("/")) distDir = distDir.substring(0, distDir.length - 1);
  var src = Directory(srcDir);
  var list = src.listSync(recursive: true);
  String indexFile = "";
  if (list.isEmpty) return false;
  if (!Directory(distDir).existsSync()) {
    Directory(distDir).createSync(recursive: true);
  }
//  var tpl=path.join(Directory.current.parent.path,"model.tpl");
//  var template= File(tpl).readAsStringSync();
//  File(path.join(Directory.current.parent.path,"model.tplx")).writeAsString(jsonEncode(template));
  File file;
  list.forEach((f) {
    if (FileSystemEntity.isFileSync(f.path)) {
      file = File(f.path);
      var paths = path.basename(f.path).split(".");
      String name = paths.first;
      if (paths.last.toLowerCase() != "json" || name.startsWith("_")) return;
      if (name.startsWith("_")) return;
      //下面生成模板
      var map = json.decode(file.readAsStringSync());
      //为了避免重复导入相同的包，我们用Set来保存生成的import语句。
      var set = new Set<String>();
      String dist = format(tplTop, [name]) + parseMap(map, set, fixed, name, tag);
      var _import = set.join(";\r\n");
      _import += _import.isEmpty ? "" : ";";
      dist = dist.replaceFirst("%t", _import);
      //将生成的模板输出
      var p = f.path.replaceFirst(srcDir, distDir).replaceFirst(".json", ".dart");
      File(p)
        ..createSync(recursive: true)
        ..writeAsStringSync(dist);
      var relative = p.replaceFirst(distDir + path.separator, "");
      indexFile += "export '$relative' ; \n";
    }
  });
  if (indexFile.isNotEmpty) {
    File(path.join(distDir, "index.dart")).writeAsStringSync(indexFile);
  }
  return indexFile.isNotEmpty;
}

///json中所有的嵌套object，防止类名重复
Map<String, int> allNestedClass = Map();

///解析map
String parseMap(Map<String, dynamic> map, Set<String> set, bool fixed, String name, String tag) {
  //保存属性
  StringBuffer attrs = new StringBuffer();
  //保存构造函数中的属性
  StringBuffer attrsCon = new StringBuffer();
  //保存json中的嵌套object
  List<String> listClass = [];
  map.forEach((key, v) {
    if (key.startsWith("_")) return;
    bool nullEnable = !key.endsWith('!');
    if (key.startsWith("@")) {
      if (key.startsWith("@import")) {
        set.add(key.substring(1) + " '$v'");
        return;
      }
      int spaceLastIndex = key.lastIndexOf(' ');
      attrs.write(key.substring(0, spaceLastIndex) +
          (fixed ? ' final' : '') +
          key.substring(spaceLastIndex, nullEnable ? key.length : key.length - 1) +
          (nullEnable ? '?' : ''));
      attrs.write(" ");
      attrs.write(v);
      attrs.writeln(";");
      addAttrsCon(fixed, attrs, attrsCon, nullEnable, key, v);
    } else {
      bool isSpecial = checkSpecial(key);
      var newKey = key.replaceAll('!', '');
      if (isSpecial) {
        attrs.write('@JsonKey(name: \'$newKey\') ');
        newKey = formatKey(newKey);
      }
      if (fixed) {
        attrs.write('final ');
      }
      String type = getType(v, set, name, tag);
      if (type == 'Map<String,dynamic>') {
        type = newKey[0].toUpperCase() + newKey.substring(1);
        if (allNestedClass.keys.contains(type)) {
          //类名已存在，修改属性类型名
          //重复次数
          var times = allNestedClass[type];
          ++times;
          allNestedClass[type] = times;
          type += '$times';
        } else {
          allNestedClass[type] = 0;
        }
        listClass.add(parseMap(v, set, fixed, newKey, tag));
      } else if (type == 'List') {
        if ((v as List).isEmpty) {
          type = "List<dynamic>";
        } else if (v[0] is Map) {
          var className = newKey[0].toUpperCase() + newKey.substring(1);
          if (allNestedClass.keys.contains(className)) {
            //类名已存在，修改属性类型名
            //重复次数
            var times = allNestedClass[className];
            ++times;
            allNestedClass[className] = times;
            className += '$times';
          } else {
            allNestedClass[className] = 0;
          }
          type = "List<$className>";
          listClass.add(parseMap(v[0], set, fixed, newKey, tag));
        } else {
          type = "List<${getType(v[0], set, name, tag)}>";
        }
      }
      attrs.write(type + (nullEnable ? '?' : ''));
      attrs.write(" ");
      attrs.write(newKey);
      attrs.writeln(";");
      addAttrsCon(fixed, attrs, attrsCon, nullEnable, newKey, v);
    }
    attrs.write("  ");
  });
  if (fixed) {
    attrsCon.write('}');
  }
  String className = name[0].toUpperCase() + name.substring(1);
  if (allNestedClass.keys.contains(className) && allNestedClass[className] > 0) {
    //修改重复类名
    className += allNestedClass[className].toString();
  }
  return format(tpl, [className, attrs.toString(), className, attrsCon.toString(), className, className, className]) +
      listClass.join();
}

addAttrsCon(bool fixed, StringBuffer attrs, StringBuffer attrsCon, bool nullEnable, String key, dynamic v) {
  if (fixed) {
    if (attrsCon.isNotEmpty) {
      attrsCon.write(', ');
    } else {
      attrsCon.write('{');
    }
    attrsCon.write((nullEnable ? '' : 'required ') + 'this.' + (key.startsWith("@") ? v : key.replaceAll('!', '')));
  } else {
    if (!nullEnable) {
      if (attrsCon.isNotEmpty) {
        attrsCon.write(', ');
      }
      attrsCon.write('this.' + (key.startsWith("@") ? v : key.replaceAll('!', '')));
    }
  }
}

String changeFirstChar(String str, [bool upper = true]) {
  return (upper ? str[0].toUpperCase() : str[0].toLowerCase()) + str.substring(1);
}

bool isBuiltInType(String type) {
  return ['int', 'num', 'string', 'double', 'map', 'list'].contains(type);
}

//将JSON类型转为对应的dart类型
String getType(v, Set<String> set, String current, tag) {
  current = current.toLowerCase();
  if (v is bool) {
    return "bool";
  } else if (v is num) {
    return "num";
  } else if (v is Map) {
    return "Map<String,dynamic>";
  } else if (v is List) {
    return "List";
  } else if (v is String) {
    //处理特殊标志
    if (v.startsWith("$tag[]")) {
      var type = changeFirstChar(v.substring(3), false);
      if (type.toLowerCase() != current && !isBuiltInType(type)) {
        set.add('import "$type.dart"');
      }
      return "List<${changeFirstChar(type)}>";
    } else if (v.startsWith(tag)) {
      var fileName = changeFirstChar(v.substring(1), false);
      if (fileName.toLowerCase() != current) {
        set.add('import "$fileName.dart"');
      }
      return changeFirstChar(fileName);
    } else if (v.startsWith("@")) {
      return v;
    }
    return "String";
  } else {
    return "String";
  }
}

//替换模板占位符
String format(String fmt, List<Object> params) {
  int matchIndex = 0;
  String replace(Match m) {
    if (matchIndex < params.length) {
      switch (m[0]) {
        case "%s":
          return params[matchIndex++].toString();
      }
    } else {
      throw new Exception("Missing parameter for string format");
    }
    throw new Exception("Invalid format string: " + m[0].toString());
  }

  return fmt.replaceAllMapped("%s", replace);
}

final String source = r'[-_]';

///判断是否有特殊符号
bool checkSpecial(String key) {
  return RegExp(source).hasMatch(key);
}

///格式化key，-_等符号一律改为小驼峰
String formatKey(String key) {
  RegExp regExp = RegExp(source);
  String newKey = key.splitMapJoin(regExp,
      onMatch: (value) => '', onNonMatch: (value) => value[0].toUpperCase() + value.substring(1));
  return newKey[0].toLowerCase() + newKey.substring(1);
}
