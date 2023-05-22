import 'package:http/http.dart' as http;

class AppString {
  static String baseURL = "http://192.168.0.102:8000/api";
  static var client = http.Client();
}
