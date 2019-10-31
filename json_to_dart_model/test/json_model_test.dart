import 'package:test/test.dart';
import 'package:json_to_dart_model/create_template_class.dart';

void main() {
  test('pascalClassName', () {
    CreateTemplateClass createTemplateClass = CreateTemplateClass();
    expect(createTemplateClass.pascalClassName('file_name-haha'), 'FileNameHaha');
  });
}
