import 'package:path/path.dart' as path;

typedef String HandlerFun(dynamic v);

class CreateTemplateClass {

  final String withPrefiex = '@with';
  final String extendsPrefix = '@extends';
  final String importPrefix = '@import';
  Map<String, HandlerFun> _typeHandlers;

  CreateTemplateClass() {
    _typeHandlers = {
      importPrefix: (imports) {
        if (imports is List) {
          return imports
            .map((v) => "import '$v';")
            .join("\r\n");
        }
        return "import '$imports';";
      },
      extendsPrefix: (v) => "extends $v",
      withPrefiex: (v) => (v is List) ? 'with ${v.join(" ")}' : "with $v"
    };
  }

  String pascalClassName(String fileName) {
    return fileName?.split(RegExp(r'_|-'))?.map((word) => '${word[0].toUpperCase()}${word.substring(1)?.toLowerCase()}')?.join();
  }

  String handlerFiled(key, v) {
    if (v is String) {
      return (
            """
  final $v $key;

"""
      );
    } else {
      Map<String, dynamic> fieldInfo = v as Map<String, dynamic>;
      return (
            """
  ${fieldInfo['pre'] ?? ''}
  final ${fieldInfo['type']} $key;

"""
      );
    }
  }

  String createDartClass({
    String name,
    String import,
    String className,
    String attrs,
    String extendClass,
    String withClass,
    List<String> fieldNames,
  }) {
    return """
// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// JsonModel Builder
// **
import 'package:json_annotation/json_annotation.dart';
$import
part '$name.g.dart';

@JsonSerializable()
class $className $extendClass $withClass{
  $className({
    ${fieldNames.map((field) => 'this.$field').join(',')}
  });

$attrs
  factory $className.fromJson(Map<String,dynamic> json) => _\$${className}FromJson(json);

  Map<String, dynamic> toJson() => _\$${className}ToJson(this);
}""";
  }

  // 根据Json生成Dart Class
  String createContent(String filePath, Map<String, dynamic> classConfigs) {
    var paths = path.basename(filePath).split(".");
    String name=paths.first;
    StringBuffer attrs = StringBuffer();
    var classInfos = {
      withPrefiex: '',
      importPrefix: '',
      extendsPrefix: '',
    };
    var fieldNames = List<String>();
    classConfigs.forEach((key, v) {
      if (_typeHandlers.containsKey(key)) {
        classInfos[key] = _typeHandlers[key](v);
      } else {
        attrs.write(handlerFiled(key, v));
        fieldNames.add(key);
      }
    });
    return createDartClass(
      name: name,
      import: classInfos[importPrefix],
      className: pascalClassName(name),
      attrs: attrs.toString(),
      extendClass: classInfos[extendsPrefix],
      withClass: classInfos[withPrefiex],
      fieldNames: fieldNames,
    );
  }
}