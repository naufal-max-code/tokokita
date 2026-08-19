import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    print("LOGIN STATUS CODE: ${response.statusCode}");
    print("LOGIN RESPON SERVER: '${response.body}'");

    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}