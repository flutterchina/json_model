import 'dart:convert';
import 'model/person.dart';

String jsonResponse = json.encode({
  "age":10,
  "first_name":"yang",
  "secondName": "yun",
  "listInt": [1, 2, 3],
  "listString": ["a", "b", "c"]
});

void main() {
  var person = Person.fromJson(json.decode(jsonResponse) as Map<String, dynamic>);
  print("${person.firstName} ${person.secondName}'s age is ${person.age}; ${person.listInt}; ${person.listStr}");
}
