import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produks = [];
    for (int i = 0; i < listProduk.length; i++) {
      produks.add(Produk.fromJson(listProduk[i]));
    }
    return produks;
  }

  static Future addProduk({Produk? produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = {
      "kode_produk": produk!.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(produk.id!);

    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };

    print("--- DEBUG UPDATE PRODUK ---");
    print("URL  : $apiUrl");
    print("BODY : $body");

    try {
      var response = await Api().post(apiUrl, body);

      print("STATUS CODE : ${response.statusCode}");
      print("RESPONSE    : ${response.body}");

      var jsonObj = json.decode(response.body);

      if (jsonObj['status'] == true || jsonObj['code'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR CATCH : $e");
      return false;
    }
  }

  static Future<bool> deleteProduk({int? id}) async {
    if (id == null) {
      print("ERROR DELETE: ID bernilai null");
      return false;
    }

    String apiUrl = ApiUrl.deleteProduk(id);

    print("--- DEBUG DELETE PRODUK ---");
    print("URL DELETE: $apiUrl");

    try {
      var response = await Api().delete(apiUrl);

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      var jsonObj = json.decode(response.body);

      // Pengecekan menyeluruh terhadap status code / key JSON
      if (response.statusCode == 200 ||
          jsonObj['status'] == true ||
          jsonObj['code'] == 200 ||
          jsonObj['data'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR CATCH DELETE: $e");
      return false;
    }
  }
}