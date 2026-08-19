import 'dart:convert';
import 'package:http/http.dart' as http; // Tambahkan baris ini
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi; // Menggunakan URL dari helper

    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'nama': nama,
        'email': email,
        'password': password,
      }),
    );

    // Cetak log untuk debugging di Flutter Console
    print("STATUS CODE: ${response.statusCode}");
    print("ISI RESPON SERVER: '${response.body}'");

    var jsonObj = json.decode(response.body);
    return Registrasi.fromJson(jsonObj);
  }
}