import 'dart:async';
import 'dart:convert';
import 'package:build/build.dart';
import './create_template_class.dart';

class JsonBuilder implements Builder {

  final CreateTemplateClass _createTemplateClass = CreateTemplateClass();

  @override
  Future build(BuildStep buildStep) async {
    var inputId = buildStep.inputId;

    var originalContents = await buildStep.readAsString(inputId);

    var copy = inputId.changeExtension('.dart');

    Map<String, dynamic> jsonInfo;
    try {
      jsonInfo = json.decode(originalContents) as Map<String, dynamic>;
    } catch (e) {
      log.warning('json decode json failed, please checked json file');
      return;
    }
    var content = _createTemplateClass.createContent(inputId.path, jsonInfo);
    await buildStep.writeAsString(copy, content);
  }

  @override
  final buildExtensions = const {
    '.json': ['.dart']
  };
}