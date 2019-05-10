//import 'package:json_model/json_model.dart';
import 'models/index.dart';

void main() {
  //run(['src=jsons']);
  var u = User.fromJson({"name": "Jack", "age": 16, "+1": 20});
  print(u.loved);
}
