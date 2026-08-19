class Registrasi {
  int? code;
  bool? status;
  String? token;

  Registrasi({this.code, this.status, this.token});

  factory Registrasi.fromJson(Map<String, dynamic> json) {
    return Registrasi(
      code: json['code'],
      status: json['status'],
      // Pastikan jika mengutip data dari object/map tidak dipaksa jadi String
      token: json['data'] != null ? json['data']['id'].toString() : null,
    );
  }
}