// GENERATED CODE - DO NOT MODIFY BY HAND
// **************************************************************************
// JsonModel Builder
// **
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person  {
  Person({
    this.age,this.firstName,this.secondName,this.listInt,this.listStr
  });

  final int age;

  @JsonKey(name: 'first_name', nullable: false)
  final String firstName;

  final String secondName;

  final List <int> listInt;

  final List <String> listStr;


  factory Person.fromJson(Map<String,dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}