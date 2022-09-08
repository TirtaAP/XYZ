import 'package:xyz/entity/user.dart';

class userhelper {
  getUser(User user) {
    Map<String, dynamic> userData = {
      "email": user.email,
      "nama": user.nama,
      "telepon": user.telepon,
      "password": user.password,
      "role": user.role,
    };
  }
}
