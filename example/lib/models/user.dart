import 'package:json_annotation/json_annotation.dart';
import 'test_dir/profile.dart';
import "card.dart";
part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    @JsonKey(ignore: true) Profile profile;
    @JsonKey(name: '+1') int loved;
    String name;
    User father;
    List<User> friends;
    List<String> keywords;
    List<Card> bankCards;
    num age;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
