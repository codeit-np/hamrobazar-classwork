import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String name = "";
  static String accessToken = "";

  static Future getUserDetail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var fullname = preferences.getString('name').toString();
    var token = preferences.getString('accessToken').toString();
    name = fullname;
    accessToken = token;
  }

  // getToken() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   token = preferences.getString("accessToken") as RxString;
  // }
}
