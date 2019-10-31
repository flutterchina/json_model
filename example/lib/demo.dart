import 'model/user_info.dart';

void main() {
  var u = UserInfo.fromJson({"name": "Jack", "age": 16, "+1": 20});
  print(u.loved);
}
